#library("http");
#source("headers.dart");
#source("request.dart");
#source("response.dart");
#source("server.dart");
#source("constants.dart");
#source("pattern_handler.dart");

interface Handler {
    Function toRequestHandler();
}
