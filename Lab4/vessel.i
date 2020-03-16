% Copyright

interface vessel
    open core

predicates
    getCapacity : () -> integer Capacity.
    getSize : () -> integer Size.
    setCapacity : (integer Capacity).
    setSize : (integer Size).
    isTransfusable : (vessel Vessel) nondeterm.
    transfuse : (vessel Vessel) -> integer Cost.
    toString : () -> string Presentaion.
    deepCopy : () -> vessel Copy.

end interface vessel
