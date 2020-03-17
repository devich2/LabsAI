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
    %String presentation of vessel
    toString() = string::format("%-l of % liters", capacity, size).

    %Copy object
    deepCopy() = Copy :-
        Copy = vessel::new(capacity, size).

clauses
%We transfuse only from non-empty can and to non-full can :)
    isTransfusable(Vessel) :-
        size > 0,
        Vessel:getSize() < Vessel:getCapacity().

%Transfuse and return amount of transfused liquid
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
