//Importación de la libreria matemática de dart, para utilizar la función random
import 'dart:math';

/*
  Esta función, se encarga de concatenar las listas de preferencias
  de hombres y mujeres, ya que el algoritmo requiere de como entrada, 
  una lista del tipo [preferencias de mujeres, preferencias de hombres]
*/
generatePreferList(n) {
  /*
    Concatencaciónn de las listas de preferencias de Mujeres y
    de Hombres en la lista prefer, la cual invoca las funciones
    generateWomanList y generateManList
  */
  List prefer = generateWomanList(n) + generateManList(n);
  return prefer;
}

// Esta función, se encara de generar listas aleatorias de tammaño n
generateLists(n, bool x) {
  /*
    Como datos de entrada, requiere de la cantidad de parejas n, 
    y del comparados booleano x.
    Declaración de la función Random de la libreria dart:math
  */
  var random = Random();
  /*
    Se condiciona la generación de lsitas, en caso de que x sea true, 
    generará listas aleatorias cuyos índices van de 0 a n-1
    en caso contrario, generará listas cuyos índices irán de n a 2n-1
  */
  if (x == true) {
    // declaración de un número random entero entre 0 y n-1
    int tmp = random.nextInt(n);
    //asignación del número random a una lsita
    List randomlist = [tmp];
    /*
      Ciclo for, encargado de crear listas de tamaño n-1, 
      con los valores de los índices de la lista de 0 a n-2
    */
    for (int i = 0; i <= n - 2; i++) {
      /*
        Ciclo while, encargado de comparar los numeros random generados, 
        asignados en la lista con el nuevo valor de número random
        así, este ciclo recorre la lista completa i veces para comparar 
        los números random generados con anterioridad, con el número random
        que se está genrando.
      */
      while (randomlist.contains(tmp)) {
        tmp = random.nextInt(n);
      }
      /*
        El for es de 0 a n-2, ya que el último valor random, se va a agregar
        en el índice n-1 de la lista, creando listas de tamaño n con valores
        de índices de las listas de 0 a n-1
      */
      randomlist.add(tmp);
    }
    return randomlist;
  } else {
    //Si el valor dado, es false, se generarán listas cuyos índices irán de n a 2n-1
    int tmp = random.nextInt(n) + n;
    List randomlist = [tmp];
    for (int i = 0; i <= n - 2; i++) {
      while (randomlist.contains(tmp)) {
        tmp = random.nextInt(n) + n;
      }
      randomlist.add(tmp);
    }
    return randomlist;
  }
}

/*
  Esta función, se encarga de generar las listas aleatorias para los
  hombres, como argumento recibe el número de parejas n
*/
generateManList(n) {
  //Se crea una lista vacía.
  List manList = [];
  /*
    Con el ciclo for, que generará listas de preferencias para cada
    hombre con íncdices de 0 a n-1, de longitud n.
  */
  for (int i = 0; i <= n - 1; i++) {
    /*
      En cada ciclo, se agrega a la lista de hombres, una lista de 
      preferencias aleatoria, invocando la función generateLists, 
      dándole como argumentos el núemro de parejas, y, para el caso
       de los hombres, un valor booleano true.
    */
    manList.add(generateLists(n, true));
  }
  //print(manList);
  return manList;
}

/*
  Esta función, se encarga de generar las listas aleatorias para las
  mujeres, como argumento recibe el número de parejas n.
*/
generateWomanList(n) {
  //Se crea una lista vacía.
  List womanList = [];
  /*
    Con el ciclo for, que generará listas de preferencias para 
    cada mujer con íncdices de 0 a n-1, de longitud n.
  */
  for (int i = 0; i <= n - 1; i++) {
    /*
      En cada ciclo, se agrega a la lista de mujeres, una lista de preferencias aleatoria,
      invocando la función generateLists, dándole como argumentos el núemro de parejas, y para el caso de las mujeres,
      un valor booleano false.
    */
    womanList.add(generateLists(n, false));
  }
  //print(womanList);
  return womanList;
}
