% Copyright
% Copyright

implement helper
    open core

clauses
    delete(X, [X | T], T).
    delete(X, [H | T], [H | NT]) :-
        delete(X, T, NT).

%Generate variation (N-size from list)
    varia(0, _, []).
    varia(N, L, [H | Varia]) :-
        N > 0,
        N1 = N - 1,
        delete(H, L, Rest),
        varia(N1, Rest, Varia).

%Generate array - e.g. Low = 0, Hie = 3, Out will be then [0,1,2,3]
    range(Low, Low, _).
    range(Out, Low, High) :-
        NewLow = Low + 1,
        NewLow <= High,
        range(Out, NewLow, High).

end implement helper
