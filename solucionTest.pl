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
:- begin_tests(puedeRealizarDisciplina).

test("Dieguito puede trepar ligustrina"):-
    puedeRealizarDisciplina(dieguito, trepadaDeLigustrina).
test("Kike no puede revolver basura", fail):-
    puedeRealizarDisciplina(kike, revolverBasura).
test("Sofy puede invadir casas"):-
    puedeRealizarDisciplina(sofy, invasionDeCasas).

:- end_tests(puedeRealizarDisciplina).
/*
5. ○	Casos de pruebas
    i.	Contu es extraña
    ii.	Nacho no es extraño
*/
:- begin_tests(esEstranio).

test("Contu es extraña", nondet):-
    esEstranio(contu).
test("Nacho no es extranio", fail):-
    esEstranio(nacho).
    
:- end_tests(esEstranio).

/*
6. ○	Casos de pruebas
    i.	Nacho le gana a Alancito en cebar mate.
    ii.	Sofy le gana a Contu en salto con ramita.
*/
:- begin_tests(ganador).

test("Nacho le gana a Alancito en cebar mate",nondet):-
    ganador(nacho,alancito,cebarMate, nacho).
test("Sofy le gana a Contu en Salto con ramita",nondet):-
    ganador(sofy,contu,saltoConRamita,sofy).

:- end_tests(ganador).

/*
7. ○	Casos de pruebas
    i.	Desarrollar un caso de prueba para cada uno de los 4 predicados
*/
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

/*
 8.   ○	Casos de pruebas
    i.	Nacho le gana a 5 en cebar mate
    ii.	Kike le gana a 4 en salto con ramita
    iii.	Sofy le gana a 6 en revolver basura
*/
:- begin_tests(aCuantosLeGana).

test("Nacho le gana a 5 en cebar mate"):-
    aCuantosLeGana(nacho,cebarMate, 5).
test("Kike le gana a 4 en salto con ramita"):-
    aCuantosLeGana(kike,saltoConRamita,4).
test("Sofy le gana a 6 en revolver basura"):-
    aCuantosLeGana(sofy,revolverBasura,6).

:- end_tests(aCuantosLeGana).


/*

 9.   ○	Casos de pruebas
    i.	Sofy la rompe en revolver basura y en huida de depredador
    ii.	Contu la rompe en preparación de ensalada 

*/

:- begin_tests(laRompeEn).

test("Sofy la rompe en revolver basura y en huida de depredador"):-
    laRompeEn(sofy,revolverBasura),
    laRompeEn(sofy,huidaDeDepredador).
test("Contu la rompe en preparacion de ensalada"):-
    laRompeEn(contu,preparacionDeEnsalada).

:- end_tests(laRompeEn).
/*
 10 ○	Casos de pruebas
    i.	Un drintim para revolver basura y preparación de ensalada está formado por Sofy y Contu.
    ii.	Un drintim para revolver basura y huida de depredador está formado únicamente por Sofy.
*/
:- begin_tests(drintim).

test("Un drintim para revolver basura y preparación de ensalada está formado por Sofy y Contu.",nondet):-
    drintim([revolverBasura,preparacionDeEnsalada],[sofy,contu]).

test("Un drintim para revolver basura y huida de depredador está formado únicamente por Sofy.",nondet):-
    drintim([revolverBasura,huidaDeDepredador],[sofy]).

:- end_tests(drintim). 
