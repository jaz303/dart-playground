class Request
{
    Request() {
        _headers = new Headers();
    }
    
    String  remoteAddress;
    int     remotePort;
    String  method;
    String  requestURI;
    
    Headers get headers() => _headers;
    void set headers(Headers hs) => _headers = hs;
    String operator[](String k) => _headers[k];
    String operator[]=(String k, String v) => _headers[k] = v;
    
    List<int> get body() => _body;
    void set body(List<int> b) => _body = b;
    int get contentLength() => (_body === null ? 0 : _body.length);
    
    Headers     _headers    = null;
    List<int>   _body       = null;
}
