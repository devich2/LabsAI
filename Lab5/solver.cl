% Copyright

class solver
    open core

domains
    state = s(vessel* Elems, move Move). %state - list of vessels/cans
    move =
        m(vessel From, vessel To, integer Cost);
        no_move. %move info
    action = (state*).

predicates
    solve : (state InitState, mapM{integer, integer} GoatState, action Action) determ.
    solve1 : (state S1, state*) -> state* List nondeterm.
    move_nd : (state Before, state After [out], integer* Group, integer Cost [out]).
    legalTransfusion : (integer* L, state State) nondeterm.
    isFinal : (state State) determ.
    toString : (state State) -> string Presentation.
    same : (vessel*, vessel*) determ.
    comp : comparator{state, state}.
    unWrapList : (state, state* [out]).

end class solver
