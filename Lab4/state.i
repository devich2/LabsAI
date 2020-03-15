% Copyright

interface state
    open core

predicates
    getElems : () -> vessel* Elems.
    deepCopy : () -> state State.
    setCost : (integer).
    setFrom : (vessel).
    setTo : (vessel).

end interface state
