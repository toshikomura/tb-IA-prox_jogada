:- prolog_language('pop11').
false -> popmemlim;
false -> pop_prolog_lim;
10e7 -> pop_callstack_lim;
true -> popdprecision;
12 -> pop_pr_places;
:- prolog_language('prolog').

concatena( [], L, L).

concatena( [ X | Xcauda], Lista, [ X | Xcauda_2]) :-
    concatena( Xcauda, Lista, Xcauda_2).

copia( L, L).

adjacente( [ [ PoteA], [ BA1, BA2, BA3, BA4], [ BB1, BB2, BB3, BB4], [ PoteB] ], a, Proxima_jogada) :-
    proximo_campo( PoteA, BA1, [], [ BA1, BA2, BA3, BA4, BB1, BB2, BB3, BB4], V, Proxima_jogada).

proximo_campo_r( Pote, 0, X, []).

proximo_campo_r( Pote, Sementes, [ 1 | Xcauda], [ Y | Ycauda]) :-
    Sementes > 0,
    Sementes_prox is Sementes - 1,
    Pote_prox is Pote + 2,
    Y is 0,
    proximo_campo_r( Pote_prox, Sementes_prox, Xcauda, Ycauda).

proximo_campo_r( Pote, Sementes, [ X | Xcauda], [ Y | Ycauda]) :-
    X \= 1,
    Sementes > 0,
    Sementes_prox is Sementes - 1,
    Y is X + 1,
    proximo_campo_r( Pote, Sementes_prox, Xcauda, Ycauda).

proximo_campo_p( Pote, Sementes, [ 0 | Xcauda], [ Y | Ycauda], V) :-
    copia( Xcauda, Ycauda),
    Y is 0.

proximo_campo_p( Pote, Sementes, [ X | Xcauda], [ Y | Ycauda], V) :-
    X \= 0,
    Sementes > 0,
    Sementes_prox is Sementes - 1,
    Y is 0,
    proximo_campo_r(Pote, Sementes_prox, Xcauda, Ycauda).

proximo_campo( Pote, Sementes, Antes, X, V, Depois) :-
    proximo_campo_p( Pote, Sementes, X, Y, V),
    concatena( Antes, Y, Depois).

% testes
% adjacente( [[0], [4,4,4,4], [4,4,4,4], [0] ], a, Saida).














