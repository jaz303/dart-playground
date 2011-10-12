class Headers implements LinkedHashMap<String,String>
{
	Headers() {
		_headers = new LinkedHashMap<String,String>();
	}

	// http://www.w3.org/Protocols/rfc2616/rfc2616-sec4.html#sec4.2
	void add(String k, String v) {
		String existing = _headers[k];
		if (existing === null) {
			_headers[k] = v;
		} else {
			_headers[k] = "${existing},${v}";
		}
	}
	
	//
	// Map impl
	
	Headers.from(Map<String,String> other) {
		_headers = new LinkedHashMap.from(other);
	}
	
	int get length() => _headers.length;
	
	String operator[](String k) => _headers[k];
	void operator[]=(String k, String v) { _headers[k] = v; }
	bool containsKey(String k) => _headers.containsKey(k);
	bool containsValue(String v) => _headers.containsValue(v);
	void forEach(void f(String, String)) { _headers.forEach(f); }
	Collection<String> getKeys() => _headers.getKeys();
	Collection<String> getValues() => _headers.getValues();
	bool isEmpty() => _headers.isEmpty();
	String putIfAbsent(String k, String ifAbsent()) { _headers.putIfAbsent(k, ifAbsent); }
	String remove(String k) { _headers.remove(k); }
	
	//
	
	LinkedHashMap<String,String> _headers;
	
}
