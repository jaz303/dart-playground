#import("http.dart", prefix: "http");

main() {
	var server = new http.Server();
	server.port = 1234;
	
	http.PatternHandler ph = new http.PatternHandler();
	
	ph.handlePattern("/foo",
	    (http.Request req, http.Response res) => res.text("foo foo foo").end()
	);
	
	ph.handlePattern("/bar",
	    (http.Request req, http.Response res) => res.text("bar bar bar").end()
	);
	
	ph.handlePattern(const RegExp(@"^/echo/(\w+)$"),
	    (http.Request req, http.Response res) {
	        String arg = req['PatternHandler.match'][1];
	        res.text("You said: ${arg}").end();
        }
	);
	
	ph.handlePattern(const RegExp(@"^.*$"),
	    (http.Request req, http.Response res) => res.textStatus(404).end()
	);
	
	server.requestHandler = ph;
	
	print("Starting server ${server}");
	server.start();
}