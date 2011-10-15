class Server
{
    Server();
    
    String address          = "0.0.0.0";
    int port                = 8080;
    int backlog             = 10;
    
    var _requestHandler     = null;
    ServerSocket _server    = null;
    
    get requestHandler() => _requestHandler;
    
    // TODO: this should probably store the original somewhere?
    set requestHandler(thing) {
        if (thing is Function) { // TODO: is it possible to check param types?
            _requestHandler = thing;
        } else {
            _requestHandler = thing.toRequestHandler();
        }
    }
    
    void start() {
        
        RegExp startMatch   = const RegExp(@"^([a-zA-Z]+)\s+([^\s]+)\s+HTTP/1.1$", false, false);
        RegExp headerMatch  = const RegExp(@"^([a-zA-Z0-9-]+):\s*([^$]+)$", false, false);
        
        _server = new ServerSocket(address, port, backlog);
        _server.setConnectionHandler(function() {
            
            Socket clientSocket     = _server.accept();
            Request request         = new Request();
            Response response       = new Response(clientSocket);
            
            // 0 - headers
            // 1 - body
            // 2 - done
            int parseState = 0;
            
            final int headerBufferSize  = 8192;
            List<int> headerBuffer      = new List<int>(headerBufferSize);
            int headerBufferPos         = 0;
            int headerBufferLength      = 0;
            
            int contentLength           = null;
            
            clientSocket.setDataHandler(function() {
            
                if (parseState == 0) {
                
                    int bytesRead = clientSocket.readList(headerBuffer,
                                                          headerBufferLength,
                                                          headerBufferSize - headerBufferLength);
                                                        
                    if (bytesRead == 0) {
                        clientSocket.close();
                        return;
                    }
                    
                    headerBufferLength += bytesRead;
                    
                    String thisLine;
                    do {
                        thisLine        = null;

                        int charCount   = 0;
                        bool wasCR      = false;
                        int i;

                        int state = 0;
                        for (i = headerBufferPos; i < headerBufferLength; i++) {
                            int ch = headerBuffer[i];
                            if (wasCR) {
                                if (ch == 10) {
                                    thisLine = new String.fromCharCodes(
                                        new List.fromList(headerBuffer, headerBufferPos, i - 1)
                                    );
                                    break;
                                } else {
                                    clientSocket.close();
                                    break;
                                }
                            } else {
                                if (ch == 13) {
                                    wasCR = true;
                                } else if (ch == 10) {
                                    thisLine = new String.fromCharCodes(
                                        new List.fromList(headerBuffer, headerBufferPos, i)
                                    );
                                    break;
                                } else {
                                    charCount++;
                                }
                            }
                        }

                        if (thisLine !== null) {
                            
                            if (charCount == 0) {
                                if (request.method === null) {
                                    clientSocket.close();
                                    return;
                                } else {
                                    if (contentLength !== null) {
                                        // TODO: append remainder of header buffer to body buffer
                                        parseState = 1;
                                    } else {
                                        this._dispatch(request, response);
                                        parseState = 2;
                                    }
                                }
                            } else if (request.method === null) {
                                Match m = startMatch.firstMatch(thisLine);
                                if (m === null) {
                                    clientSocket.close();
                                    return;
                                } else {
                                    request.method = m[1];
                                    request.requestURI = m[2];
                                }
                            } else {
                                Match m = headerMatch.firstMatch(thisLine);
                                if (m === null) {
                                    clientSocket.close();
                                    return;
                                } else {
                                    String k = m[1];
                                    String v = m[2];
                                    if (k == "Content-Length") {
                                        contentLength = Math.parseInt(v); // TODO: catch error
                                    }
                                    request.headers.add(k, v);
                                }
                            }
                            
                            headerBufferPos = i + 1;
                            if (headerBufferPos >= headerBufferLength) {
                                break;
                            }
                            
                        } else {
                            break;
                        }

                    } while (true);
                    
                } else if (parseState == 1) {
                    
                    clientSocket.readList(request.body, request.body.length, contentLength - request.body.length);
                    if (request.body.length == contentLength) {
                        this._dispatch(request, response);
                        parseState = 2;
                    }
                
                } else {
                    
                    clientSocket.close();
                
                }
                
            });
        });
    }
    
    void close() {
        if (_server !== null) _server.close();
    }
    
    void _dispatch(Request request, Response response) {
        if (this._requestHandler !== null) {
            this._requestHandler(request, response);
        }
    }
    
    String toString() => "http.Server(address=${this.address},port=${this.port})";

}