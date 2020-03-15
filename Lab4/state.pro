% Copyright

implement state
    open core

facts
    elems : vessel*.
    cost : integer := 0.
    fromV : vessel := erroneous.
    toV : vessel := erroneous.

clauses
    new(Vessels) :-
        elems := Vessels.
    getElems() = elems.
    setCost(Cost) :-
        cost := Cost.
    setFrom(From) :-
        fromV := From.
    setTo(To) :-
        toV := To.
    deepCopy() = Copy :-
        OldElems = [ L || L = list::getMember_nd(elems) ],
        State = state::new(OldElems),
        if isErroneous(fromV) and isErroneous(toV) then
        else
            stdio::write("here"),
            State:setFrom(fromV),
            State:setTo(toV)
        end if,
        State:setCost(cost),
        Copy = State.

end implement state
