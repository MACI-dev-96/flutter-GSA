// import 'package:algoritmo_g_s_runtime/src/match.dart';
// import 'dart:math';

// List<T3> zipList<T1, T2, T3>(
//     List<T1> l1, List<T2> l2, T3 Function(T1, T2) zipper) {
//   if (l1.isEmpty)
//     throw ArgumentError.value(l1, "l1", "input list cannot be empty");
//   if (l1.length != l2.length)
//     throw ArgumentError("Two lists must have the same length");
//   var result = List<T3>.filled(l1.length);
//   for (var i = 0; i < l1.length; i++) {
//     result.add(zipper(l1[i], l2[i]));
//   }
//   return result;
// }

// // here a quick example of how to use it.
// class ExecutionTime {
//   final int i;
//   final int s;
//   ExecutionTime(this.i, this.s);

//   @override
//   String toString() => "Bar: $i - $s";
// }

// void testZipList(max) {
//   List time = [];
//   List numeroDeparejas = [];
//   for (int i = 0; i <= max; i++) {
//     int n = pow(2, i);
//     time.add(Matches().stableMarriage(n));
//     numeroDeparejas.add(n);
//   }
//   List list1 = time;
//   List list2 = numeroDeparejas;
//   List executionTimeChartData = zipList(list1, list2, (l1, l2) => ExecutionTime(l1, l2));
//   executionTimeChartData.forEach(print);
// }

import 'dart:math';
import 'package:algoritmo_g_s_runtime/src/match.dart';

class ExecutionTime {
  int etime;
  int coupleNumber;
  ExecutionTime(this.etime, this.coupleNumber);
}

executionTimeData(max) {
  List time = [];
  List numeroDeparejas = [];
  List<ExecutionTime> chartData = [];
  for (int i = 0; i <= max; i++) {
    int n = pow(2, i);
    time.add(Matches().stableMarriage(n));
    numeroDeparejas.add(n);
  }
  for (int i = 0; i <= time.length-1; i++) {
    chartData.add(ExecutionTime(time[i], numeroDeparejas[i]));
  }
  return chartData;
}
