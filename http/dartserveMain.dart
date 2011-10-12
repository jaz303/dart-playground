#import("http.dart", prefix: "http");

//This is a modification on jaz303's dart server; this one actually serves content instead of just URL echoing.
//modification written by Josh Leverette.
//
//Bug #001: files are arbitrarily limited to 48KB and I don't know why.
//Difficulty: Unknown, but shouldn't be too hard.


//at one point, isText(String)
//was used, but isn't any more.
//cruft code if you will.
bool isText(String type) {
    if (type == 'text/plain')
        return true;
    else if (type == 'text/html')
        return true;
    else if (type == 'text/css')
        return true;
    else if (type == 'text/js')
        return true;
    else if (type == 'text/dart')
        return true;
    else 
        return false;
}

main() {
	var server = new http.Server();
	server.port = 1234;
	
	server.requestHandler = function(http.Request request, http.Response response) {
	    //reduce number of calls to requestURI
	    String reqs = request.requestURI;
	    //find the extension type and place that as the content type
	    int lindex = reqs.lastIndexOf(".", reqs.length-1);
	    if (lindex != -1)
	    {
	        String ext = reqs.substring(lindex+1);
	        //for non-text types it should be something else.. but I haven't implemented anything here to handle that. isText(String) might be helpful.
		    response.contentType = "text/$ext";
		}
		else
		{
		    response.contentType = "text/plain";
		}
		//open the file requested
		File req = new File("html/$reqs", false);
		//name the file in the response (for debugging purposes only)
        response.URI = reqs;
        //make a list to store the bytes in
	    List<int> str = new List<int>();
		if (req != null)
		{
		    int i = 0;
    		int len = req.length;
	        while (i++ < len)
	            str.addLast(req.readByte());
	        //close the file
	        req.close();
	    }
	    else //give a 404 error message for not-found files
	    {
	        response.status = 404;
	        response.contentType = "text/plain"; //404 should always be plain text or html
	        str = "Error 404:\n\nthe URL $reqs could not be found.\n\nWe're sorry! :(".charCodes();
        }
		response.body = new String.fromCharCodes(str);
		response.end();
	};
	
	print("Starting server ${server}\n");
	server.start();
}
