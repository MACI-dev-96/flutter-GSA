import 'package:algoritmo_g_s_runtime/src/preferences_generator.dart';

class Matches {
  mPrefersW1OverW(prefer, m, w, w1, n) {
    for (var i = 0; i <= n; i++) {
      if (prefer[m][i] == w1) {
        return true;
      }
      if (prefer[m][i] == w) {
        return false;
      }
    }
  }

  stableMarriage(n) {
    var stopwatch = Stopwatch()..start();
    stopwatch.reset();
    stopwatch.start();
    List prefer = generatePreferList(n);
    stopwatch.stop();
    int st = stopwatch.elapsedMilliseconds.toInt();
    print('Tiempo de ejecución de generación de listas= $st');
    stopwatch.reset();
    stopwatch.start();
    dynamic freeCount, m, w, w1;
    List mPartner = List.generate(n, (index) => index * 0);
    List wFree = List.generate(n, (index) => index * 0);
    for (int i = 0; i <= n - 1; i++) {
      mPartner[i] = -1;
    }
    for (int i = 0; i <= n - 1; i++) {
      wFree[i] = false;
    }

    freeCount = n;
    while (freeCount > 0) {
      w = 0;
      while (w < n) {
        if (wFree[w] == false) {
          break;
        }
        w++;
      }
      int i = 0;
      while ((i < n) && (wFree[w] == false)) {
        m = prefer[w][i];
        if (mPartner[m - n] == -1) {
          mPartner[m - n] = w;
          wFree[w] = true;
          freeCount--;
        } else {
          w1 = mPartner[m - n];
          if (mPrefersW1OverW(prefer, m, w, w1, n) == false) {
            mPartner[m - n] = w;
            wFree[w] = true;
            wFree[w1] = false;
          }
        }
        i++;
      }
    }
    stopwatch.stop();
    int stf = stopwatch.elapsedMilliseconds.toInt();
    return stf;
  }
}
