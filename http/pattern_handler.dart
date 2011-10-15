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
                    p.handler(request, matches[0], response);
                    break;
                }
            }
        };
    }
}

class PatternTuple {
    PatternTuple(Pattern this.pattern, Function this.handler);
    Pattern pattern;
    Function handler;
}
