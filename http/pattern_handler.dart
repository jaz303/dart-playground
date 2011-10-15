class PatternHandler
{
    List<_Pattern> _patterns;
    
    PatternHandler() {
        _patterns = <_Pattern>[];
    }
    
    handlePattern(Pattern pattern, Function handler) {
        _patterns.add(new _Pattern(pattern, handler));
    }
    
    toRequestHandler() {
        return (Request request, Response response) {
            for (_Pattern p in _patterns) {
                var matches = p.pattern.allMatches(request.requestURI);
                if (matches.length > 0) {
                    p.handler(request, matches[0], response);
                    break;
                }
            }
        };
    }
}

class _Pattern {
    Pattern pattern;
    Function handler;
    
    _Pattern(Pattern this.pattern, Function this.handler);
}