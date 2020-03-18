% Copyright

class solver
    open core

domains
    state = s(vessel* Elems). %state - list of vessels/cans
    move = m(vessel From, vessel To, state NewState, integer Cost). %move info

predicates
    solve : (state InitState, mapM{integer, integer} Goal) -> move* MoveList determ.
    solve1 : (state S1, state* PreviousStates) -> move* MoveList nondeterm.
    move_nd : (state Before, state After [out], integer* Group) -> move Move.
    legalTransfusion : (integer* L, state State) nondeterm.
    isFinal : (state State) determ.
    toString : (state State) -> string Presentation.
    same : (vessel*, vessel*) determ.
    comp : comparator{state, state}.

end class
