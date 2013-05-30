homem( jose).
homem( joao).
homem( flavio).
mulher( maria).
mulher( ana).
mulher( bruna).
casal( jose, maria).
casal( joao, ana).
filho( flavio, jose).
filho( flavio, maria).
filha( bruna, jose).
filha( bruna, maria).

irmao( X, Y) :-
    ( homem( X) ; mulher( X)),
    ( homem( Y) ; mulher( Y)),
    homem( Z1),
    mulher( Z2),
    ( filho( X, Z1) ; filha( X, Z1)),
    ( filho( Y, Z2) ; filha( Y, Z2)),
    casal( Z1, Z2),
    X \== Y.
