import 'package:algoritmo_g_s_runtime/src/preferences_generator.dart';

/*
  Variables principales:
  m = hombre
  w = mujer
  w1 = mujer 1
  n = número de parejas
  prefer = preferencia
*/
class Matches {
  // Esta funciónn regresa true si hombre 'm' prefiere a la mujer 'w1' sobre la mujer 'w'
  mPrefersW1OverW(prefer, m, w, w1, n) {
    // Verificando si el hombre prefiere a 'w' sobre su actual pareja 'w1'
    for (var i = 0; i <= n; i++) {
      /*
        Si 'w1' viene antes de 'w' en la lista de 'm',
        entonces 'm' prefiere su actual pareja, por lo tanto, 
        no se hace nada
      */
      if (prefer[m][i] == w1) {
        return true;
      }

      /* 
        Si 'w' viene antes de 'w1' en la lista de 'm',
        entonces libera su actual pareja y emparejalo con 'w'
      */
      if (prefer[m][i] == w) {
        return false;
      }
    }
  }

  /* 
    Muestra el emparejamiento estable para N mujeres y N hombres
    Las mujeres son numeradas como 0 a N-1
    Los hombres son numerados como N a 2N-1
  */
  stableMarriage(n) {
    // Creación de nuestras variables principales
    dynamic freeCount, m, w, w1;

    // Instanciación e inicialización de nuestro cronómetro
    var stopwatch = Stopwatch()..start();

    // Reinicio del cronómetro
    stopwatch.reset();

    /* 
      Inicio del cronómetro para calcular el tiempo de la generación 
      de listas de preferencia aleatorias 
    */
    stopwatch.start();    
    // Generando las listas aleatorias llamando a la función que lo realiza
    List prefer = generatePreferList(n);
    // El cronómetro se detiene una vez se haya completado la creación de listas
    stopwatch.stop();
    // Se guarda el valor de tiempo del conómetro y se imprime en consola
    int st = stopwatch.elapsedMilliseconds.toInt();
    print('Tiempo de ejecución de generación de listas= $st');
    
    // Reinicio del cronómetro
    stopwatch.reset();

    // Inicio del cronómetro para calcular el tiempo ejecución del algoritmo
    stopwatch.start();
    
    /*     
      Almacena pareja de 'm'. Esta es nuestra matriz de salida que almacena información de paginación. 
      El valor de mPartner[i] indica la pareja asignada a 'm' en N + i. 
      Tener en cuenta que los números de 'm' entre N y 2 * N-1. 
      El valor -1 indica que 'm' (N + i) está libre
    */
    List mPartner = List.generate(n, (index) => index * 0);
    for (int i = 0; i <= n - 1; i++) {
      mPartner[i] = -1;
    }
    
    /* 
      Un arreglo que almacena las mujeres disponibles.
      Si wFree[i] es falso, entonces el w[i] esta libre,
      sino, ya tiene pareja
    */
    List wFree = List.generate(n, (index) => index * 0);
    for (int i = 0; i <= n - 1; i++) {
      wFree[i] = false;
    }

    freeCount = n;
    // Mientras haya una mujer libre
    while (freeCount > 0) {

      // Selecciona a la primera mujer libre
      w = 0;
      while (w < n) {
        if (wFree[w] == false) {
          break;
        }
        w++;
      }

      /*
        Uno por uno van a todos los hombres de acuerdo a las preferencias de las mujeres.
        Aqui mujer es la elegida como la mujer libre
      */
      int i = 0;
      while ((i < n) && (wFree[w] == false)) {
        m = prefer[w][i];

        /*
          La preferencia de 'm' esta libre, 
          'm' y 'w' serán pareja (esto puede cambiar después)
        */
        if (mPartner[m - n] == -1) {
          mPartner[m - n] = w;
          wFree[w] = true;
          freeCount--;
        } else {
          /* 
            Si 'm' no esta libre           
            Encontrar la pareja actual de 'm'
          */
          w1 = mPartner[m - n];

          /*
            Si 'm' prefiere a la 'w' sobre su actual pareja 'w1',
            entonces rompemos el emparejamiento entre el 'm' y 'w1' y
            emparejamos a 'm' con 'w'
          */
          if (mPrefersW1OverW(prefer, m, w, w1, n) == false) {
            mPartner[m - n] = w;
            wFree[w] = true;
            wFree[w1] = false;
          }
        }
        i++;
      }
    }
    // Se detiene el cronometro, ya que finalizó la ejecución del algoritmo
    stopwatch.stop();

    // Guardamos en una variable el tiempo total de ejecución
    int stf = stopwatch.elapsedMilliseconds.toInt();

    // Retornamos el tiempo total de ejecución
    return stf;
  }
}
