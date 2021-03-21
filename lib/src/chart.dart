/*
  Importación de los paquetes y librerias necesarios para
  ejecutar el código y realizar la graficación de los resultados.
*/
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:algoritmo_g_s_runtime/src/match.dart';

/*
 la clase ChartPage, es la encargada de generar las gráficas y ejecutar
 el código del algoritmo y generación automática de listas de preferancias
 aleatorias.
  Flutter, utiliza los Widgets, para dibujar los datos, 
  en el caso de los StatefulWidget, los utiliza para dibujar 
  datos de manera interactiva, como lo hace en las gráficas.
*/
class ChartPage extends StatefulWidget {
  ChartPage({Key key}) : super(key: key);
  @override
  ChartPageState createState() => ChartPageState();
}

/*
  ChartPageState, es la clase encargada de manejar los widgets 
  de manera interactiva, es una clase, hija de de la clase principal
  ChartPage.
*/
class ChartPageState extends State<ChartPage> {
  /*
    Se crea una lista data, invocando  la función executionTime, dandole cómo 
    argumento, el máximo de datos que se quieren generar en la función de incremento
    automático de parejas n implementada en la misma.
    La lista data, contiene tuplas del tipo (tiempo de ejecución, número de parejas)
  */
  List data = executionTimeData(10);
  @override
  Widget build(BuildContext context) {
    //Se obtiene el tamaño de la pantalla del dispositivo donde se mostrarán las gráficas
    final screenSize = MediaQuery.of(context).size;
    /*
      Scaffold, es un widget predefinido por flutter, que se encarga de renderizar el cuerpo
      general de la aplicación.
    */
    return Scaffold(
      /*
        AppBar es un widget predefinido por flutter, que se encarga de renderizar una barra
        en la parte superior de la aplicación
      */
      appBar: AppBar(
        title: Text('Graficación de tiempos de ejecución algoritmo G-S'),
      ),
      /*
        El body, o cuerpo de la aplicación, todo lo que va a estar contenido
        en el Scaffold
      */
      body: Center(
        child: Container(
          height: screenSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 300,
                width: screenSize.width,
                /*
                  "child", es el widget hijo de un widget padre, ya que la 
                  renderización de objetos se da de acuerdo a estas jerarquias.
                  SfCartesianChart, es un widget predeterminado de la libreria
                  syncfusion_flutter_charts, que se encarga de renderizar en forma 
                  de gráfica, los datos que recibe.
                */
                child: SfCartesianChart(
                  //Se asignan los nombres a los ejes de la gráfica
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(
                      text: 'Numero de Parejas "n"',
                      textStyle: TextStyle(fontSize: 11, color: Colors.blue),
                    ),
                  ),
                  primaryYAxis: CategoryAxis(
                    title: AxisTitle(
                      text: 'Tiempo (ms)',
                      textStyle: TextStyle(fontSize: 11, color: Colors.blue),
                    ),
                  ),
                  // Titulo de la gráfica
                  title: ChartTitle(
                      text:
                          'Tiempo de ejecución del Algoritmo G-S para "n" parejas',
                      textStyle:
                          TextStyle(fontSize: 23, color: Colors.blue[900])),
                  // Se activa la legenda del gráfico
                  legend: Legend(
                    isVisible: true,
                  ),
                  /*
                    tooltip, es para anotar los valores del eje "y" 
                    sobre la linea del gráfico 
                  */
                  tooltipBehavior: TooltipBehavior(enable: true),
                  /*
                    series, es el encargado de graficar la linea en el gráfico,
                    y asignar los valores a los ejes del mismo.
                  */
                  series: <ChartSeries<ExecutionTime, String>>[
                    LineSeries<ExecutionTime, String>(
                      /*
                        data source, recibe datos, de tipo tuplas, en este caso,
                        recibe los valores de la lista data.
                      */
                      dataSource: data,
                      /*
                        Se asignan los valores de mapeo del eje x, 
                        para la generación de la linea del gráfico.
                      */
                      xValueMapper: (ExecutionTime data, _) =>
                          data.coupleNumber.toString(),
                      xAxisName: 'Número de parejas',
                      /*
                        Se asignan los valores de mapeo del eje y, 
                        para la generación de la linea del gráfico.
                      */
                      yValueMapper: (ExecutionTime data, _) => data.etime,
                      yAxisName: 'Tiempo (ms)',
                      //Se asigna el nobre de la leyenda del gráfico
                      name: 'Tiempo de ejecución',
                      //Se activan los valores de las etiquetas de datos en los ejes
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
              /*
                Se crea un contenedor para la renderización de la tabla
              */
              Container(
                width: 200,
                /*
                  Table es un widget predefinido de flutter, que rederiza datos
                  de forma tabular.
                */
                child: Table(
                  //Configuración visual de la tabla
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(
                    color: Colors.blueAccent,
                    width: 2,
                  ),
                  /*
                    Asignación de los datos contenidos en la tabla, como la tabla
                    es de tamaño n, se invoca a la función de generador de filas
                    tableRowGenerator, dandole como argumento la lista data.
                  */
                  children: tableRowGenerator(data),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
  función encargada de acomodar los datos de la lista data
  en filas.
*/
tableRowGenerator(data)  {
  //Se crean los encabezados de las columnas
  List<TableRow> tableRowList = [
    TableRow(
      children: [
        Text(
          'Numero de Parejas (n)',
          textAlign: TextAlign.center,
        ),
        Text('Tiempo (ms)', textAlign: TextAlign.center),
      ],
    )
  ];
  /*
    Ciclo for, encargado de mapear la lista data, para asignar
    los datos contenidos en esta a cada una de las filas.
  */
  for (int i = 0; i <= data.length - 1; i++) {
    tableRowList.add(
      TableRow(
        children: [
          /*
            Se asigna el valor numero de parejas de la tupla de la posición
            i de la lista data, a un texto.
          */
          Text(
            data[i].coupleNumber.toString(),
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          /*
            Se asigna el valor tiempo de ejecución de la tupla de la posición
            i de la lista data, a un texto.
          */
          Text(
            data[i].etime.toString(),
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  return tableRowList;
}

/*
  Se crea una clase ExecutionTime, que nos permita manejar los datos
  retornados por el código, especificamente, el tiempo de ejecución
  del algoritmo, y el número de parejas generadas, en forma de tuplas.
*/
class ExecutionTime {
  int etime;
  int coupleNumber;
  ExecutionTime(this.etime, this.coupleNumber);
}

/*
  La función executionTimeData, se encarga de generar una lista
  time, con el tiempo de ejecución retornado por el algoritmo GS,
  y uina lista numeroDeparejas, que almacena la cantidad de parejas
  n, generadas por la función exponencial.
*/
executionTimeData(max) {
  /*
    Se inicializa un cronómetro, para medir el timepo total
    de ejecución de la función, que contempla, el tiempo de ejecución
    del algoritmo GS, el tiempo de ejecución del algoritmo de generación
    automática de listas de preferencias, la asignación de los valores que
    retornan cada uno de estos algoritmos a su propia lista, y la conversión
    de las listas de algorimos,a instancias de la clase ExecutionTime,
    que nos permite manejar los datos en tuplas, y así poder graficarlos.
  */
  var stopwatch = Stopwatch()..start();

  //Se realiza un reseteo al cronómeto, para ponerlo en ceros.
  stopwatch.reset();
  //Se incia la cuenta del cronómetro.
  stopwatch.start();
  /*
    Creación de las listas vacias de tiempo de ejecución "time",
    número de parejas "numeroDeparejas" y una lista vacia condicionada
    a contener datos del tipo tupla, de la clase ExecutionTime.
  */
  List time = [];
  List numeroDeparejas = [];
  List<ExecutionTime> chartData = [];
  /*
    Con el ciclo for, se generan los datos del número de parejas,
    de manera exponencial, utilizando el dos como base, e i como el
    exponente, además, se invoca la función stableMarriage, encargada
    de realizar los matches con el algoritmo GS, para que se ejecute con
    el número de parejas n generado en cada ciclo.
  */
  for (int i = 0; i <= max; i++) {
    /*
      Asignación del número de parejas n, a traves de una función exponencial
      con base 2, se eligió esta base, para poder generar varios puntos en la gráfica
      y poder observar su comportamiento conforme a lso incrementos de n.
    */
    int n = pow(2, i);
    /*
      Se agregan los valores del tiempo de ejecución del algoritmo a la lista 
      time, ya que la función stableMarriage, retorna el tiempo de ejecución del
      algoritmo GS.
    */
    time.add(Matches().stableMarriage(n));
    /*
      Se almacena el número de parejas generado en cada uno de los ciclos
      en la lista numeroDeparejas
    */
    numeroDeparejas.add(n);
  }

  /*
    Este ciclo se encarga de asignar los valores de las listas time y numeroDeparejas
    a la lista condicionada de la clase ExecutionTime, generando una lista de tuplas
    (tiempo de ejecución, número de parejas n).
  */
  for (int i = 0; i <= time.length - 1; i++) {
    chartData.add(ExecutionTime(time[i], numeroDeparejas[i]));
  }
  //Se finaliza la cuenta del cronómetro
  stopwatch.stop();
  /*
    Se almacena la cuenta del cronómetro en una variable stpet,
    asignandole el timepo transcurrido de la cuenta, en milisegundos
  */
  int stpet = stopwatch.elapsedMilliseconds.toInt();
  /*
    Se realiza la impresión del tiempo total de ejecución de la función
    en la consola
  */
  print('Tiempo total de ejecución = $stpet');
  //re retorna la lista de tuplas chartData.
  return chartData;
}
