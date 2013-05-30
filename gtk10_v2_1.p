concatena( [], L, L).

concatena( [ X | Cauda], Lista, [ X | Cauda_2]) :-
    concatena( Cauda, Lista, Cauda_2).

andando_buraco( [], []).

andando_buraco( [ X | Xcauda], [ Y | Ycauda] ) :-
    Y is X - 1,
    andando_buraco( Xcauda, Ycauda).

adjacente( [ PoteA, A, B, PoteB], Jogador, Saida) :-
    Jogador == 'a',
    concatena( A, B, Campo),
    proxima_jogada( PoteA, A, B, PoteB, Campo),
    contem_valor( 1, G, I, PoteA, Prox_PoteA),
    proximo_campo( [ Prox_PoteA, I, D, PoteB], Saida).

proximo_campo( [ PoteA, A, B, PoteB], Saida) :-
    concatena( [ PoteA], [ A], Saida1),
    concatena( [ B], [PoteB], Saida2),
    concatena(Saida1, Saida2, Saida).

testa_buraca1( [A | Acuada], [ X | Xcauda]) :-
    X is A -1.

contem_valor( Z, [], [], Pote, Prox_Pote) :-
    Prox_Pote is Pote.

contem_valor( Z, [ Z | Xcauda], [ Y | Ycauda], Pote, Prox_Pote) :-
    Y is 0,
    contem_valor( Z, Xcauda, Ycauda, Pote, AntProx_Pote),
    Prox_Pote is AntProx_Pote + 2.

contem_valor( Z, [ X | Xcauda], [ Y | Ycauda], Pote, Prox_Pote) :-
    Y is X,
    contem_valor(Z, Xcauda, Ycauda, Pote, Prox_Pote).

proxima_jogada( PoteA, [], B, PoteB, Campo).

proxima_jogada( PoteA, [ A | Acauda], B, PoteB, [ Campo | Campocauda]) :-
    Sementes is A,
    proxima_jogada( PoteA, Acauda, B, PoteB, Campocauda),
    andando_buraco( Campocauda, Campocauda_prox).











