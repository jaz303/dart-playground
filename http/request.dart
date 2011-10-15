class Request
{
    Request() {
        _headers = new Headers();
        _context = <String,Object>{};
    }
    
    String  remoteAddress;
    int     remotePort;
    String  method;
    String  requestURI;
    
    Headers get headers() => _headers;
    void set headers(Headers hs) => _headers = hs;
    
    //
    // Allow arbitrary data to be stashed on request
    
    Object operator[](String k) => _context[k];
    Object operator[]=(String k, Object v) => _context[k] = v;
    
    List<int> get body() => _body;
    void set body(List<int> b) => _body = b;
    int get contentLength() => (_body === null ? 0 : _body.length);
    
    Headers                 _headers    = null;
    List<int>               _body       = null;
    Map<String,Object>      _context    = null;
}
