/*
  Importación de los paquetes de las librerias material 
  (encargada de la compatibilidad de dart con flutter),
  y del archivo chart.dart, en dónde se realizan las
  tareas de graficación y tabulación de datos.
*/
import 'package:algoritmo_g_s_runtime/src/chart.dart';
import 'package:flutter/material.dart';

/*
  Se crea una app, compatible con las versiones 
  móbil, escritorio y web.
*/
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*
          Al ser ejecutada, la aplicación invoca a las clase
          ChartPage, en donde se realizan las tareas de graficación,
          y ejecución del código.
        */
      title: 'Algoritmo G-S graficación',
      debugShowCheckedModeBanner: false,
      home: ChartPage(),
    );
  }
}
