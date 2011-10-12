class Response
{
	Response(Socket socket) {
		_status = 200;
		_headers = new Headers();
		_headers['Content-Type'] = 'text/html';
		_socket = socket;
	}

	int get status() => _status;
	void set status(int s) => _status = s;
	
	String get contentType() => _headers['Content-Type'];
	void set contentType(String ct) => _headers['Content-Type'] = ct;

	String get body() => _body;
	void set body(String b) => _body = b;
	
	void end() {
	
		StringBuffer buffer = new StringBuffer();
		
		buffer.add("HTTP/1.1 ${_status} Foo\r\n");
		
		_headers.forEach(function(String k, String v) {
			buffer.add("${k}: ${v}\r\n");
		});
		
		buffer.add("\r\n");
		
		int requiredSize = buffer.length;
		if (_body !== null) {
			requiredSize += _body.length;
		}
		
		List<int> outBytes = new List<int>(requiredSize);
		outBytes.copyFrom(buffer.toString().charCodes(), 0, 0, buffer.length);
		
		if (_body !== null) {
			outBytes.copyFrom(_body.charCodes(), 0, buffer.length, _body.length);
		}
	
		int totalWritten = 0;
		_socket.setWriteHandler(function() {
			int bytesWritten = _socket.writeList(outBytes, totalWritten, outBytes.length - totalWritten);
			totalWritten += bytesWritten;
			if (totalWritten == outBytes.length) _socket.close();
		});
		
	}

	int			_status;
	Headers		_headers;
	String		_body;
	Socket		_socket;
}