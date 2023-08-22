/*
Solución TP de logico
Integrantes:
 - Integrante 1: Agustin Lobianco
 - Integrante 2: Flavio Milossi
*/

/*
1.	Modelar con functores a cada uno de los carpinchos 
    y definir un predicado para indicar la existencia y poder usar de generador.

*/

%carpincho(Nombre,Habilidades,atributos(Fuerza, Destreza, Velocidad)).

carpincho(kike, ["saltar", "correr"], atributos(100,50,40)).
carpincho(nacho, ["olfatear", "saltar"], atributos(60,80,80)).
carpincho(alancito, ["correr"], atributos(80,80,70)).
carpincho(gastoncito, ["olfatear"], atributos(100,30,20)).
carpincho(sofy, ["saltar", "correr", "olfatear"], atributos(100,90,100)).
carpincho(dieguito, ["saltar", "correr", "trepar"], atributos(99,99,80)).
carpincho(contu, ["olfatear", "saltar", "contabilidad hogareña", "lavar"], atributos(60,70,60)).

existeCarpincho(Nombre) :- carpincho(Nombre, _, _).

/*
2.	Modelar las disciplinas en relación a sus restricciones.
*/
%disciplina(Nombre, RestriccionHabilidades, RestriccionAtributos).
disciplina(saltoConRamita, ["saltar", "correr"],atributos(0,0,0)).
disciplina(armadoDeMadriguera, [], atributos(70,0,0)).
disciplina(huidaDeDepredador, ["correr", "olfatear"], atributos(0,0,80)).
disciplina(preparacionDeEnsalada, ["olfatear", "saltar", "contabilidad hogareña"], atributos(0,0,0)).
disciplina(trepadaDeLigustrina, ["saltar", "correr", "trepar"], atributos(0,0,0)).
disciplina(invasionDeCasas, [], atributos(50,90,0)).
disciplina(revolverBasura, ["correr", "olfatear"], atributos(0,0,50)).
disciplina(cebarMate, ["olfatear"], atributos(0,0,0)). %nacho, gastoncito, sofy / kike


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
    disciplina(Nombre,RestriccionHabilidades,atributos(Fuerza,Destreza,Velocidad)),
        length(RestriccionHabilidades,Cantidad),
        sumaAtributos(atributos(Fuerza,Destreza,Velocidad),SumaTotal),
        (Cantidad > 2;SumaTotal > 100).


sumaAtributos(atributos(Fuerza,Destreza,Velocidad), Suma):-
    Suma is Fuerza + Destreza + Velocidad.


/*
        
4.	Implementar un predicado que relacione el nombre de un carpincho 
        y el nombre de una disciplina, si el primero puede realizarla.

Notas del apunte:

    subset: indica si un conjunto es subcnjunto de un conjunto
    subset([1, 2], [1, 2, 3]).
    true.

*/
puedeRealizarDisciplina(Carpincho, cebarMate):-
    carpincho(Carpincho, Habilidades, atributos(Fuerza, Destreza, Velocidad)),
    disciplina(cebarMate, RestriccionHabilidades, atributos(FuerzaRequerida, DestrezaRequerida, VelocidadRequerida)),
    cumpleHabilidades(Habilidades, RestriccionHabilidades),
    not(cumpleHabilidades(Habilidades, ["lavar"])),
    cumpleAtributos(atributos(Fuerza, Destreza, Velocidad),atributos(FuerzaRequerida, DestrezaRequerida, VelocidadRequerida)).

puedeRealizarDisciplina(Carpincho, Disciplina):-
    carpincho(Carpincho, Habilidades, atributos(Fuerza, Destreza, Velocidad)),
    disciplina(Disciplina, RestriccionHabilidades, atributos(FuerzaRequerida, DestrezaRequerida, VelocidadRequerida)),
    Disciplina \= cebarMate,
    cumpleHabilidades(Habilidades, RestriccionHabilidades),
    cumpleAtributos(atributos(Fuerza, Destreza, Velocidad),atributos(FuerzaRequerida, DestrezaRequerida, VelocidadRequerida)). 
 
cumpleAtributos(atributos(Fuerza, Destreza, Velocidad),atributos(FuerzaRequerida, DestrezaRequerida, VelocidadRequerida)):-
    Fuerza >= FuerzaRequerida,
    Destreza >= DestrezaRequerida,
    Velocidad >= VelocidadRequerida.

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

esExtranio(Carpincho):-
    carpincho(Carpincho,_,_),
    forall(puedeRealizarDisciplina(Carpincho, Disciplina),disciplinaEsDificil(Disciplina)). 
    


/*
6.	Saber, dados dos carpinchos y el nombre de una disciplina, cuál es el ganador, sabiendo que: 

    ○	Si los dos pueden realizar la disciplina, gana el que tenga más sumatoria de atributos.
    ○	Si uno solo puede realizarla, es el ganador.
    ○	Si ninguno la realiza, ninguno gana.

    Nota: Pensar... ¿Cuántas cosas se deben relacionar?
*/
/*Si los dos pueden realizar la disciplina, gana el que tenga más sumatoria de atributos.*/
ganador(Carpincho1, Carpincho2, Disciplina, Ganador):-
    carpincho(Carpincho1,_,atributos(Fuerza1,Destreza1,Velocidad1)),
    carpincho(Carpincho2,_,atributos(Fuerza2,Destreza2,Velocidad2)),
    Carpincho1 \= Carpincho2,
    puedeRealizarDisciplina(Carpincho1,Disciplina),
    puedeRealizarDisciplina(Carpincho2,Disciplina),
    sumaAtributos(atributos(Fuerza1,Destreza1,Velocidad1),Suma1),
    sumaAtributos(atributos(Fuerza2,Destreza2,Velocidad2),Suma2),
    (Suma1 > Suma2 -> Ganador = Carpincho1;
    Suma2 > Suma1 -> Ganador = Carpincho2).

/*   ○	Si uno solo puede realizarla, es el ganador.*/
ganador(Carpincho1, Carpincho2, Disciplina, Ganador):-
    carpincho(Carpincho1,_,_),
    carpincho(Carpincho2,_,_),
    Carpincho1 \= Carpincho2,
    puedeRealizarDisciplina(Carpincho1,Disciplina),
    not(puedeRealizarDisciplina(Carpincho2,Disciplina)),
    Ganador = Carpincho1.

ganador(Carpincho1, Carpincho2, Disciplina, Ganador):-
    carpincho(Carpincho1,_,_),
    carpincho(Carpincho2,_,_),
    Carpincho1 \= Carpincho2,
    not(puedeRealizarDisciplina(Carpincho1,Disciplina)),
    puedeRealizarDisciplina(Carpincho2,Disciplina),
    Ganador = Carpincho2.

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
pesasCarpinchas(Carpincho, Peso, carpincho(Carpincho,_,atributos(NuevaFuerza,Destreza,Velocidad))):-
    carpincho(Carpincho,_,atributos(Fuerza,Destreza,Velocidad)),
    NuevaFuerza is (Fuerza + (Peso/4)).

/*○	atrapaLaRana/3: aumenta la destreza en igual cantidad que las ranas atrapadas.*/
atrapaLaRana(Carpincho, RanasAtrapadas, carpincho(Carpincho,_,atributos(Fuerza,NuevaDestreza,Velocidad))):-
    carpincho(Carpincho,_,atributos(Fuerza,Destreza,Velocidad)),
    NuevaDestreza is (Destreza + RanasAtrapadas).

/* ○	cardiopincho/3: aumenta la velocidad el doble de los kilómetros recorridos 
    (claramente, recorridos en cinta, porque no podían salir a entrenar).*/

cardioPincho(Carpincho, KilometrosRecorridos, carpincho(Carpincho,_,atributos(Fuerza,Destreza,NuevaVelocidad))):-
    carpincho(Carpincho,_,atributos(Fuerza,Destreza,Velocidad)),
    NuevaVelocidad is (Velocidad + (KilometrosRecorridos*2)).

/*○	carssfit/3: aumenta la destreza y la fuerza en la cantidad de minutos que se entrena, 
    pero también baja la velocidad el doble de esa cantidad.*/

carssfit(Carpincho, MinutosEntrenados, carpincho(Carpincho,_,atributos(NuevaFuerza,NuevaDestreza,NuevaVelocidad))):-
    carpincho(Carpincho,_,atributos(Fuerza,Destreza,Velocidad)),
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
noGanaEn(Carpincho, Disciplina):-
    existeCarpincho(Carpincho),
    existeCarpincho(Rival),
    Carpincho \= Rival,
    disciplina(Disciplina,_,_),
    ganador(Carpincho,Rival,Disciplina,Rival).
    
    
laRompeEn(Carpincho, Disciplina):-
    existeCarpincho(Carpincho),
    disciplina(Disciplina,_,_),
    not(noGanaEn(Carpincho, Disciplina)).


/*
    10.	A partir de una lista de nombres de disciplinas, 
    poder generar un Drintim (un equipo) de carpinchos 
    donde cada uno de los integrantes sea el ganador indiscutido en cada disciplina, 
    es decir, el que más gana.
    Nota: No hace falta que este predicado sea inversible para las disciplinas, sí para el equipo.
   ○	Casos de pruebas
    i.	Un drintim para revolver basura y preparación de ensalada está formado por Sofy y Contu.
    ii.	Un drintim para revolver basura y huida de depredador está formado únicamente por Sofy.
  */  


equipoEstrella([], []).
equipoEstrella([Disciplina|ColaDisciplina], [Carpincho|ColaCarpincho]):-
    carpincho(Carpincho,_,_),
    laRompeEn(Carpincho, Disciplina),
    equipoEstrella(ColaDisciplina, ColaCarpincho).


drinTim(Disciplinas, Carpinchos):-
    equipoEstrella(Disciplinas, Lista),
    list_to_set(Lista, Carpinchos).