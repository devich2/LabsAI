% Copyright

interface solver
    open core

predicates
    isFinal : (state State) nondeterm.
    generateStates : (state State) -> state* List.
    unWrapList : (state Final).
    solve : (state Initial) nondeterm.
    changeState : (state Initial, vessel* Group) -> state State.
    append : (A*, A*, A* [out]) nondeterm.
    equals : comparator{vessel, vessel}.
    rec_solve : (state) multi.

end interface solver
