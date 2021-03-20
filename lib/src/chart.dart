import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:algoritmo_g_s_runtime/src/match.dart';

class ChartPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ChartPage({Key key}) : super(key: key);

  @override
  ChartPageState createState() => ChartPageState();
}

class ChartPageState extends State<ChartPage> {
  List data = executionTimeData(5);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Graficación de tiempos de ejecución algoritmo G-S'),
      ),
      body: Center(
        child: Container(
          height: screenSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 300,
                width: 900,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    name: 'Numero de parejas',
                    placeLabelsNearAxisLine: true,
                  ),
                  // Chart title
                  title: ChartTitle(
                      text: 'Tiempo de ejecución Algoritmo para n parejas',
                      textStyle: TextStyle(fontSize: 23)),
                  // Enable legend
                  legend: Legend(
                    isVisible: false,
                  ),
                  // Enable tooltip

                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<ExecutionTime, String>>[
                    LineSeries<ExecutionTime, String>(
                      dataSource: data,
                      xValueMapper: (ExecutionTime data, _) =>
                          data.coupleNumber.toString(),
                      xAxisName: 'Número de parejas',
                      yValueMapper: (ExecutionTime data, _) => data.etime,
                      yAxisName: 'Tiempo (ms)',
                      name: 'Tiempo de ejecución',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
              Container(
                width: 200,
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(
                    color: Colors.blueAccent,
                    width: 2,
                  ),
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

tableRowGenerator(data) {
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
  for (int i = 0; i <= data.length - 1; i++) {
    tableRowList.add(
      TableRow(
        children: [
          Text(
            data[i].coupleNumber.toString(),
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
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

class ExecutionTime {
  int etime;
  int coupleNumber;
  ExecutionTime(this.etime, this.coupleNumber);
}

executionTimeData(max) {
  var stopwatch = Stopwatch()..start();
  stopwatch.reset();
  stopwatch.start();
  List time = [];
  List numeroDeparejas = [];
  List<ExecutionTime> chartData = [];
  for (int i = 0; i <= max; i++) {
    int n = pow(2, i);
    time.add(Matches().stableMarriage(n));
    numeroDeparejas.add(n);
  }

  for (int i = 0; i <= time.length - 1; i++) {
    chartData.add(ExecutionTime(time[i], numeroDeparejas[i]));
  }
  stopwatch.stop();
  int stpet = stopwatch.elapsedMilliseconds.toInt();
  print('Tiempo total de ejecución = $stpet');
  return chartData;
}
