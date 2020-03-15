% Copyright
% Copyright

implement helper
    open core

clauses
    delete(X, [X | T], T).
    delete(X, [H | T], [H | NT]) :-
        delete(X, T, NT).

    varia(0, _, []).
    varia(N, L, [H | Varia]) :-
        N > 0,
        N1 = N - 1,
        delete(H, L, Rest),
        varia(N1, Rest, Varia).
    pop(E, [E | Es], Es).

    push(E, Es, [E | Es]).

end implement helper
