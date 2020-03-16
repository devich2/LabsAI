% Copyright

interface state
    open core

predicates
    getElems : () -> vessel* Elems.
    deepCopy : () -> state State.
    setCost : (integer).
    setFrom : (vessel).
    setTo : (vessel).
    toString : () -> string Presentation.
    setParent : (state Parent).
    getParent : () -> state Parent.
    empty_parent : () determ.

end interface state
