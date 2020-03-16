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

    range(Low, Low, High).
    range(Out, Low, High) :-
        NewLow = Low + 1,
        NewLow <= High,
        range(Out, NewLow, High).

end implement helper
