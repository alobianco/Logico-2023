:- include(solucion).

%Que disciplina es dificil
:- begin_tests(disciplinaEsDificil).

test("Trepada de Ligustrina es una disciplina dificil", nondet):-
    disciplinaDificil(trepadaDeLigustrina).
test("Invasión de casas es una disciplina difícil", nondet):-
    disciplinaDificil(invasionDeCasas).
test("Armado de Madriguera no es dificil",fail):-
    disciplinaDificil(armadoDeMadriguera).

:- end_tests(disciplinaEsDificil).

%Carpinchos pueden realizar disciplinas
:- begin_tests(puedeRealizarDisciplina).

test("Dieguito puede trepar ligustrina"):-
    participaEnDisciplina(dieguito, trepadaDeLigustrina).
test("Kike no puede revolver basura", fail):-
    participaEnDisciplina(kike, revolverBasura).
test("Sofy puede invadir casas"):-
    participaEnDisciplina(sofy, invasionDeCasas).

:- end_tests(puedeRealizarDisciplina).

%Carpinchos extraños
:- begin_tests(carpinchoExtranio).

test("Contu es extrania", nondet):-
    extranio(contu).
test("Nacho no es extranio", fail):-
    extranio(nacho).

:- end_tests(carpinchoExtranio).

%Entrenamiento de carpinchos
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



