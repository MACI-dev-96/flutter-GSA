import 'dart:math';

generatePreferList(n) {
  List prefer = generateWomanList(n)+generateManList(n);
  return prefer;
}

//List<List>
generateLists(n, bool x) {
  var random = Random();
  if (x == true) {
    int tmp = random.nextInt(n);
    List randomlist = [tmp];
    for (int i = 0; i <= n - 2; i++) {
      while (randomlist.contains(tmp)) {
        tmp = random.nextInt(n);
      }
      randomlist.add(tmp);
    }
    return randomlist;
  } else {
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

generateManList(n) {
  List manList = [];
  for (int i = 0; i <= n - 1; i++) {
    manList.add(generateLists(n, true));
  }
  //print(manList);
  return manList;
}

generateWomanList(n) {
  List womanList = [];
  for (int i = 0; i <= n - 1; i++) {
    womanList.add(generateLists(n, false));
  }
  //print(womanList);
  return womanList;
}
