#import("http.dart", prefix: "http");

main() {
	var server = new http.Server();
	server.port = 1234;
	
	server.requestHandler = (http.Request request, http.Response response) {
		response.contentType = 'text/plain';
		response.body = request.requestURI;
		response.end();
	};
	
	print("Starting server ${server}");
	server.start();
}