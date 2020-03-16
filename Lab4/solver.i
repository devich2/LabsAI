% Copyright

interface solver
    open core

predicates
    isFinal : (state State) nondeterm.
    generateStates : (state State) -> state* List.
    unWrapList : (state Final, state* Prev) -> state* Result.
    solve : (state Initial) nondeterm.
    changeState : (state Initial, integer* Group) -> state State.
    equals : comparator{vessel, vessel}.
    rec_solve : (state) multi.
    same : (vessel*, vessel*) determ.
    cp : comparator{vessel, vessel}.
    comp : comparator{state, state}.

end interface solver
