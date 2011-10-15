class Response
{
    Headers     _headers;
    Socket      _socket;
    
    Response(Socket socket) {
        status = 200;
        _headers = new Headers();
        _headers['Content-Type'] = 'text/html';
        _socket = socket;
    }
    
    int status;
    var body;
    
    String get contentType() => _headers['Content-Type'];
    void set contentType(String ct) => _headers['Content-Type'] = ct;

    String URI;
    
    void end() {
    
        StringBuffer buffer = new StringBuffer();
        
        buffer.add("HTTP/1.1 ${status} ${Constants.textForStatus(status)}\r\n");
        
        _headers.forEach(function(String k, String v) {
            buffer.add("${k}: ${v}\r\n");
        });
        
        buffer.add("\r\n");
        
        int requiredSize = buffer.length;
        if (body !== null) {
            requiredSize += body.length;
        }
        
        List<int> outBytes = new List<int>(requiredSize);
        outBytes.copyFrom(buffer.toString().charCodes(), 0, 0, buffer.length);
        
        if (body !== null) {
            outBytes.copyFrom(body.charCodes(), 0, buffer.length, body.length);
        }
        int totalWritten = 0;
        _socket.setWriteHandler(function() {
            int bytesWritten = _socket.writeList(outBytes, totalWritten, outBytes.length - totalWritten);
            totalWritten += bytesWritten;
            print("KB sent for $URI: ${totalWritten / 1024}\n");
            /*if (totalWritten == outBytes.length)*/ _socket.close();
        });
        
    }


}
