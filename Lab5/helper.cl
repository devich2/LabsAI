% Copyright

class helper
    open core

predicates
    delete : (A [out], A*, A* [out]) nondeterm.
    varia : (integer, A2*, A2* [out]) nondeterm.
    range : (integer [out], integer, integer) multi.

end class helper
