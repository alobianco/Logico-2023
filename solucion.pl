/*
Solución TP de logico
Integrantes:
 - Integrante 1
 - Integrante 2
*/

/*
1.	Modelar con functores a cada uno de los carpinchos 
    y definir un predicado para indicar la existencia y poder usar de generador.

*/

%carpincho(Nombre,Habilidades,Atributos).

carpincho(kike, ["saltar", "correr"], [100,50,40]).
carpincho(nacho, ["olfatear", "saltar"], [60,80,80]).
carpincho(alancito, ["correr"], [80,80,70]).
carpincho(gastoncito, ["olfatear"], [100,30,20]).
carpincho(sofy, ["saltar", "correr", "olfatear"], [100,90,100]).
carpincho(dieguito, ["saltar", "correr", "trepar"], [99,99,80]).
carpincho(contu, ["olfatear", "saltar", "contabilidad hogareña", lavar], [60,70,60]).

existeCarpincho(Nombre) :- carpincho(Nombre, _, _).

/*
2.	Modelar las disciplinas en relación a sus restricciones.
*/
%disciplina(Nombre, RestriccionHabilidades, RestriccionAtributos).
disciplina(saltoConRamita, ["saltar", "correr"],[0,0,0]).
disciplina(armadoDeMadriguera, [], [70,0,0]).
disciplina(huidaDeDepredador, ["correr", "olfatear"], [0,0,80]).
disciplina(preparacionDeEnsalada, ["olfatear", "saltar", "contabilidad hogareña"], [0,0,0]).
disciplina(trepadaDeLigustrina, ["saltar", "correr", "trepar"], [0,0,0]).
disciplina(invasionDeCasas, [], [50,90,0]).
disciplina(revolverBasura, ["correr", "olfatear"], [0,0,50]).
disciplina(cebarMate, ["olfatear"], [0,0,0]).


/*
3.	Saber si una disciplina, dada su nombre, es difícil: 
    Esto ocurre cuando se requieren más de 2 habilidades, 
    o bien suma más de 100 puntos de atributos en los requerimientos.

○	Casos de pruebas
    i.	Trepada de Ligustrina es una disciplina difícil
    ii.	Invasión de casas es una disciplina difícil
    iii.	Armado de Madriguera no es difícil

*/

disciplinaEsDificil(Nombre):-
    disciplina(Nombre,RestriccionHabilidades,RestriccionAtributos),
        length(RestriccionHabilidades,Cantidad),
        sum_list(RestriccionAtributos,Puntos),
        (Cantidad > 2;Puntos > 100).


/*
        
4.	Implementar un predicado que relacione el nombre de un carpincho 
        y el nombre de una disciplina, si el primero puede realizarla.

Notas del apunte:

    subset: indica si un conjunto es subcnjunto de un conjunto
    subset([1, 2], [1, 2, 3]).
    true.

*/

puedeRealizarDisciplina(Carpincho, Disciplina) :-
    carpincho(Carpincho, Habilidades, Atributos),
    disciplina(Disciplina, RestriccionHabilidades, RestriccionAtributos),
    cumpleHabilidades(Habilidades, RestriccionHabilidades),
    cumpleAtributos(Atributos,RestriccionAtributos).
 
cumpleAtributos([], []).
cumpleAtributos([HeadAtributoCarpincho | Atributos], [HeadAtributoRestriccion | AtributosRestricciones]):-
    HeadAtributoCarpincho >= HeadAtributoRestriccion,
    cumpleAtributos(Atributos, AtributosRestricciones).

cumpleHabilidades(HabilidadesCarpincho,HabilidadesRestriccion):-
    intersection(HabilidadesCarpincho, HabilidadesRestriccion, ListaIntersecta),
    ListaIntersecta = HabilidadesRestriccion.


/*

5.	Saber si un carpincho es extraño a partir de su nombre, 
    esto pasa cuando todas las disciplinas que puede realizar son difíciles.
    ○	Casos de pruebas
        i.	Contu es extraña
        ii.	Nacho no es extraño
*/

esEstranio(Carpincho):-
    puedeRealizarDisciplina(Carpincho,Disciplina),
    disciplinaEsDificil(Disciplina).


/*
6.	Saber, dados dos carpinchos y el nombre de una disciplina, cuál es el ganador, sabiendo que: 

    ○	Si los dos pueden realizar la disciplina, gana el que tenga más sumatoria de atributos.
    ○	Si uno solo puede realizarla, es el ganador.
    ○	Si ninguno la realiza, ninguno gana.

    Nota: Pensar... ¿Cuántas cosas se deben relacionar?
*/
/*Si los dos pueden realizar la disciplina, gana el que tenga más sumatoria de atributos.*/
ganador(Carpincho1, Carpincho2, Disciplina, Ganador):-
    carpincho(Carpincho1,_,AtributosCarpincho1),
    carpincho(Carpincho2,_,AtributosCarpincho2),
    puedeRealizarDisciplina(Carpincho1,Disciplina),
    puedeRealizarDisciplina(Carpincho2,Disciplina),
    sum_list(AtributosCarpincho1, Sum1),
    sum_list(AtributosCarpincho2, Sum2),
    (Sum1 > Sum2 -> Ganador = Carpincho1;
    Sum2 > Sum1 -> Ganador = Carpincho2).

/*   ○	Si uno solo puede realizarla, es el ganador.*/
ganador(Carpincho1, Carpincho2, Disciplina, Ganador):-
    carpincho(Carpincho1,_,_),
    carpincho(Carpincho2,_,_),
    puedeRealizarDisciplina(Carpincho1,Disciplina),
    not(puedeRealizarDisciplina(Carpincho2,Disciplina)),
    Ganador = Carpincho1.

ganador(Carpincho1, Carpincho2, Disciplina, Ganador):-
    carpincho(Carpincho1,_,_),
    carpincho(Carpincho2,_,_),
    not(puedeRealizarDisciplina(Carpincho1,Disciplina)),
    puedeRealizarDisciplina(Carpincho2,Disciplina),
    Ganador = Carpincho2.

/*Si ninguno la realiza, ninguno gana.*/
ganador(Carpincho1, Carpincho2, Disciplina, Ganador):-
    carpincho(Carpincho1,_,_),
    carpincho(Carpincho2,_,_),
    not(puedeRealizarDisciplina(Carpincho1,Disciplina)),
    not(puedeRealizarDisciplina(Carpincho2,Disciplina)),
    Ganador = [].

/*
7.	Durante la cuarentena, nuestros amiguitos estuvieron preparándose 
    para este gran evento deportivo con distintos entrenamientos. 
    
    Implementar los siguientes entrenamientos, que relacionan una cantidad, 
    un carpincho (completo) a entrenar y el mismo carpincho después de entrenar:

    Nota: No hace falta que estos 4 predicados sean inversibles para ninguno de sus argumentos.
 

*/

/* ○	pesasCarpinchas/3: aumenta la fuerza de un carpincho    
        un cuarto de la cantidad de peso que levantaron.
*/
pesasCarpinchas(Carpincho, Peso, carpincho(Carpincho,_,[NuevaFuerza,Destreza,Velocidad])):-
    carpincho(Carpincho,_,[Fuerza,Destreza,Velocidad]),
    NuevaFuerza is (Fuerza + (Peso/4)).

/*○	atrapaLaRana/3: aumenta la destreza en igual cantidad que las ranas atrapadas.*/
atrapaLaRana(Carpincho, RanasAtrapadas, carpincho(Carpincho,_,[Fuerza,NuevaDestreza,Velocidad])):-
    carpincho(Carpincho,_,[Fuerza,Destreza,Velocidad]),
    NuevaDestreza is (Destreza + RanasAtrapadas).

/* ○	cardiopincho/3: aumenta la velocidad el doble de los kilómetros recorridos 
    (claramente, recorridos en cinta, porque no podían salir a entrenar).*/

cardioPincho(Carpincho, KilometrosRecorridos, carpincho(Carpincho,_,[Fuerza,Destreza,NuevaVelocidad])):-
    carpincho(Carpincho,_,[Fuerza,Destreza,Velocidad]),
    NuevaVelocidad is (Velocidad + (KilometrosRecorridos*2)).

/*○	carssfit/3: aumenta la destreza y la fuerza en la cantidad de minutos que se entrena, 
    pero también baja la velocidad el doble de esa cantidad.*/

carssfit(Carpincho, MinutosEntrenados, carpincho(Carpincho,_,[NuevaFuerza,NuevaDestreza,NuevaVelocidad])):-
    carpincho(Carpincho,_,[Fuerza,Destreza,Velocidad]),
    NuevaFuerza is (Fuerza + MinutosEntrenados),
    NuevaDestreza is (Destreza + MinutosEntrenados),
    NuevaVelocidad is (Velocidad - (MinutosEntrenados*2)).


/*
8.	Hacer aCuantosLesGana/3. 
    Que relaciona el nombre de un carpincho, nombre de disciplina y la cantidad de carpinchos 
    a los que les gana en esa disciplina.
*/

aCuantosLeGana(Carpincho, Disciplina, Cantidad) :-
    carpincho(Carpincho, _, _),
    disciplina(Disciplina, _, _),
    findall(Carpincho2, (carpincho(Carpincho2, _, _),Carpincho \= Carpincho2,ganador(Carpincho, Carpincho2, Disciplina, Carpincho)), Resultados),
    length(Resultados, Cantidad).


/*
9.	Hacer laRompeEn/2, que relaciona el nombre de un carpincho y una disciplina, 
    si dicho carpincho gana siempre en dicha disciplina.

*/

laRompeEn(Carpincho, Disciplina) :-
    carpincho(Carpincho, _, _),
    disciplina(Disciplina, _, _),
    ganaSiempreEn(Carpincho, Disciplina).

ganaSiempreEn(Carpincho, Disciplina) :-
    findall(Carpincho2, 
        (carpincho(Carpincho2, _, _),Carpincho = Carpincho2,
        ganador(Carpincho, Carpincho2, Disciplina, Carpincho)), 
        Resultados),
    length(Resultados, 0).

/*==========================================================================================*/
/*
drinTim([], []).
drinTim([Disciplina|ColaDisciplina], [Carpincho|ColaCarpincho]):-
    carpincho(Carpincho,_,_),
    call(laRompeEn, Disciplina, Carpincho),
    drinTim(ColaDisciplina, ColaCarpincho).

*/



    

