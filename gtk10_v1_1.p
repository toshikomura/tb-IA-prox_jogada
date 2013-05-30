concatena([], [], []).

concatena( Valor, [], [Cl | Clcauda]) :-
    Cl is Valor,
    concatena([], [], Clcauda).

concatena( Valor, [Lis | Liscauda], [Cl | Clcauda]) :-
    Cl is Valor,
    concatena(Lis, Liscauda, Clcauda).

adjacente( PA, [], [], PB, Z, []).

adjacente( PA, [A | Acauda], [B | Bcauda], PB, Z, [Prox | Proxcauda]) :-
    Z == 'a',
    N1 is A + 1,
    N2 is B + 1,
    N is N1 + N2,
    Prox is N,
    concatena( B, Bcauda, ConcatB),
    adjacente( PA, Acauda, ConcatB, PB, Z, Proxcauda).


adjacente( PA, [], [B | Bcauda], PB, Z, [Prox | Proxcauda]) :-
    Z == 'a',
    N is B + 20,
    Prox is N,
    adjacente( PA, [], Bcauda, PB, Z, Proxcauda).
