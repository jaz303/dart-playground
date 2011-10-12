class Request
{
    Request() {
        _headers = new Headers();
    }

    String get remoteAddress() => _remoteAddress;
    void set remoteAddress(String ra) => _remoteAddress = ra;
    
    int get remotePort() => _remotePort;
    void set remotePort(int rp) => _remotePort = rp;
    
    String get method() => _method;
    void set method(String m) => _method = m.toUpperCase();
    
    String get requestURI() => _requestURI;
    void set requestURI(String uri) => _requestURI = uri;
    
    Headers get headers() => _headers;
    void set headers(Headers hs) => _headers = hs;
    String operator[](String k) => _headers[k];
    String operator[]=(String k, String v) => _headers[k] = v;
    
    List<int> get body() => _body;
    void set body(List<int> b) => _body = b;
    int get contentLength() => (_body === null ? 0 : _body.length);
    
    String      _remoteAddress      = null;
    int         _remotePort         = null;
    String      _method             = null;
    String      _requestURI         = null;
    Headers     _headers                = null;
    List<int>   _body                   = null;
}
