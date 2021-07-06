// import 'package:flutter/material.dart';
// //import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class BarcodeScanPage extends StatefulWidget {
//
//
//   @override
//   _BarcodeScanPageState createState() => _BarcodeScanPageState();
// }
//
// class _BarcodeScanPageState extends State<BarcodeScanPage> {
//   // ignore: non_constant_identifier_names
//   String scanResult;
//
// //   Future scanBarcode()async{
// //     final status = await Permission.camera.request();
// //     String scRe;
// //     if (status.isGranted) {
// //       print("Start Scaan");
// //       scRe=await FlutterBarcodeScanner.scanBarcode(
// //           "#ff66666", "Cancel", true, ScanMode.BARCODE);
// // if(!mounted) return;
// //
// //       // var dir = await getApplicationDocumentsDirectory();
// //     }
// //   }
//
//
//   Future<void> startBarcodeScanStream() async {
//     // FlutterBarcodeScanner.scanBarcode(
//     //     '#ff6666', 'Cancel', true, ScanMode.BARCODE).then((value) => setState(() {
//     //   scanResult=value;
//     //   print(value);
//     // },),);
//
//   }  @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(primary: Colors.amber),
//               onPressed: startBarcodeScanStream,
//               icon: Icon(Icons.camera_alt_outlined),
//               label: Text("Start Scan"),
//
//             ),
//             SizedBox(height: 10),
//             Text(scanResult==null?"scan code result":"scan result: $scanResult",
//               textAlign: TextAlign.center,
//             )
//
//           ],
//         ),
//       ),
//     );
//   }
//
// }
