% Copyright

implement state
    open core

facts
    elems : vessel*.
    cost : integer := 0.
    fromV : vessel := erroneous.
    toV : vessel := erroneous.
    parent : state := erroneous.

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
        OldElems =
            [ L ||
                Y = list::getMember_nd(elems),
                L = Y:deepCopy()
            ],
        State = state::new(OldElems),
        if isErroneous(fromV) and isErroneous(toV) then
        else
            State:setFrom(fromV:deepCopy()),
            State:setTo(toV:deepCopy())
        end if,
        State:setCost(cost),
        Copy = State.

clauses
    setParent(Parent) :-
        parent := Parent.
    getParent() = parent.
    empty_parent() :-
        isErroneous(parent).

clauses
    toString() = string::format("Step: %\nState: %\n", Change, State) :-
        if not(isErroneous(fromV)) and not(isErroneous(toV)) then
            Change = string::format("From % to %", fromV:toString(), toV:toString())
        else
            Change = "No move"
        end if,
        StringList =
            [ L ||
                Y = list::getMember_nd(elems),
                L = Y:toString()
            ],
        State = string::concatWithDelimiter(StringList, ", ").

end implement state
