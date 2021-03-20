//  GridView.builder(
//                       itemCount: data.length,
//                       shrinkWrap: true,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Container(
//                           height: 20,
//                           width: 160,
//                           color: Colors.red,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 data[index].coupleNumber.toString(),
//                                 style: TextStyle(
//                                     fontSize: 12, color: Colors.black),
//                               ),
//                               SizedBox(
//                                 width: 120,
//                               ),
//                               Text(
//                                 data[index].etime.toString(),
//                                 style: TextStyle(
//                                     fontSize: 12, color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                       gridDelegate: SliverGridRegularTileLayout(
//                         crossAxisSpacing: 5.0,
//                         mainAxisSpacing: 5.0, 
//                         maxCrossAxisExtent: 200,
//                       ),
//                     ),