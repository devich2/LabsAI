% Copyright

class helper
    open core

predicates
    delete : (A [out], A*, A* [out]) nondeterm.
    varia : (integer, A2*, A2* [out]) nondeterm.
    push : (A, A*, A*) determ.
    pop : (A, A*, A*) determ.

end class helper
