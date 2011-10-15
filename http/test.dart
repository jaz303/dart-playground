#import("http.dart", prefix: "http");

main() {
	var server = new http.Server();
	server.port = 1234;
	
	http.PatternHandler ph = new http.PatternHandler();
	
	ph.handlePattern("/foo",
	    (http.Request _r, Match _m, http.Response r) => r.text("foo foo foo").end()
	);
	
	ph.handlePattern("/bar",
	    (http.Request _r, Match _m, http.Response r) => r.text("bar bar bar").end()
	);
	
	ph.handlePattern(const RegExp(@"^/echo/(\w+)$"),
	    (http.Request _r, Match m, http.Response r) => r.text("You said: ${m[1]}").end()
	);
	
	ph.handlePattern(const RegExp(@"^.*$"),
	    (http.Request _, Match m, http.Response r) => r.textStatus(404).end()
	);
	
	server.requestHandler = ph;
	
	print("Starting server ${server}");
	server.start();
}