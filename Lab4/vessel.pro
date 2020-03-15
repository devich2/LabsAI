% Copyright

implement vessel
    open core

facts
    capacity : integer.
    size : integer.

clauses
    new(Capacity, Size) :-
        capacity := Capacity,
        size := Size.

clauses
    getSize() = size.
    getCapacity() = capacity.

clauses
    setCapacity(Capacity) :-
        capacity := Capacity.
    setSize(Size) :-
        size := Size.

clauses
    isTransfusable(Vessel) :-
        size > 0,
        Vessel:getSize() < Vessel:getCapacity().

    transfuse(Vessel) = Cost :-
        Max = size,
        Allowed = Vessel:getCapacity() - Vessel:getSize(),
        if Max < Allowed then
            Added = Max
        else
            Added = Allowed
        end if,
        Vessel:setSize(Vessel:getSize() + Added),
        size := getSize() - Added,
        Cost = Added.

end implement vessel
