:- include(solucion).


/*  3.
	
    Casos de pruebas
    i.	Trepada de Ligustrina es una disciplina difícil
    ii.	Invasión de casas es una disciplina difícil
    iii.	Armado de Madriguera no es difícil

*/
:- begin_tests(disciplinaEsDificil).

test("Trepada de Ligustrina es una disciplina difícil", nondet):-
    disciplinaEsDificil(trepadaDeLigustrina).
test("Invasión de casas es una disciplina difícil", nondet):-
    disciplinaEsDificil(invasionDeCasas).
test("Armado de Madriguera no es difícil",fail):-
    disciplinaEsDificil(armadoDeMadriguera).

:- end_tests(disciplinaEsDificil).


/*
    4.	Casos de pruebas
        i.	Dieguito puede trepar ligustrina
        ii.	Kike no  puede revolver basura
        iii.	Sofy puede invadir casas
*/

% Carpinchos pueden realizar disciplinas

:- begin_tests(puedeRealizarDisciplina).

test("Dieguito puede trepar ligustrina"):-
    puedeRealizarDisciplina(dieguito, trepadaDeLigustrina).
test("Kike no puede revolver basura", fail):-
    puedeRealizarDisciplina(kike, revolverBasura).
test("Sofy puede invadir casas"):-
    puedeRealizarDisciplina(sofy, invasionDeCasas).

:- end_tests(puedeRealizarDisciplina).


/*

% Carpinchos extraños
:- begin_tests(carpinchoExtranio).

test("Contu es extrania", nondet):-
    extranio(contu).
test("Nacho no es extranio", fail):-
    extranio(nacho).

:- end_tests(carpinchoExtranio).

% Quien Gana?
:- begin_tests(quienGanaEn).

test("Nacho le gana a Alancito en cebar mate",nondet):-
    quienGanaEn(nacho,alancito,cebarMate, nacho).
test("Sofy le gana a Contu en Salto con ramita",nondet):-
    quienGanaEn(sofy,contu,saltoConRamita,sofy).

:- end_tests(quienGanaEn).

% Entrenamiento de carpinchos
:- begin_tests(entrenamientoDeCarpinchos).

test("Despues de levantar 20 kilos Kike tiene 105 de fuerza"):-
    pesasCarpinchas(kike,20,carpincho(kike,_, [105,50,40])).
test("Contu atrapo 10 ranas y ahora tiene 80 de destreza"):-
    atrapaLaRana(contu,10,carpincho(contu, _, [60,80,60])).
test("Alancito se mato corriendo 45 kilometros y ahora tiene 160 de velocidad"):-
    cardioPincho(alancito,45,carpincho(alancito, _, [80,80,160])).
test("dieguito hizo carssfit durante 25 minutos y ahora tiene [124,124,30] de Atributos"):-
    carssfit(dieguito,25,carpincho(dieguito, _, [124,124,30])).

:- end_tests(entrenamientoDeCarpinchos).

% A cuantos le gana cada uno?
:- begin_tests(aCuantosLeGana).

test("Nacho le gana a 5 carpinchos en cebar mate"):-
    aCuantosLeGana(nacho,cebarMate, 5).
test("Kike le gana a 4 carpinchos en Salto con ramita"):-
    aCuantosLeGana(kike,saltoConRamita,4).
test("Sofy le gana a 6 carpinchos en revolver basura"):-
    aCuantosLeGana(sofy,revolverBasura,6).

:- end_tests(aCuantosLeGana).

% Gana todas las disciplinas
:- begin_tests(laRompeEn).

test("Sofy la rompe en revolver basura y en huida de depredador"):-
    laRompeEn(sofy,revolverBasura),
    laRompeEn(sofy,huidaDeDepredador).
test("Contu la rompe en preparacion de ensalada"):-
    laRompeEn(contu,preparacionDeEnsalada).

:- end_tests(laRompeEn).

*/
