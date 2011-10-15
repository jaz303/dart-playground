class PatternHandler implements Handler
{
    List<PatternTuple> _patterns;
    
    PatternHandler() {
        _patterns = <PatternTuple>[];
    }
    
    handlePattern(Pattern pattern, Function handler) {
        _patterns.add(new PatternTuple(pattern, handler));
    }
    
    Function toRequestHandler() {
        return (Request request, Response response) {
            for (PatternTuple p in _patterns) {
                var matches = p.pattern.allMatches(request.requestURI);
                if (matches.length > 0) {
                    request['PatternHandler.matchingPattern'] = p.pattern;
                    request['PatternHandler.match'] = matches[0];
                    p.handler(request, response);
                    break;
                }
            }
        };
    }
}

class PatternTuple {
    PatternTuple(Pattern this.pattern, Function this.handler);
    final Pattern pattern;
    final Function handler;
}
