// import 'dart:io';
//
// import 'package:backdrop/app_bar.dart';
// import 'package:backdrop/backdrop.dart';
// import 'package:backdrop/scaffold.dart';
// import 'package:employee_attendance/tasks_provider/provider_data.dart';
// import 'package:employee_attendance/widget/back_layer.dart';
// import 'package:employee_attendance/widget/front_layer.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   loadQrImage() async {
//     final Directory path =
//         Directory("/storage/emulated/0/download_barcode/");
//     print("DDDDDDDD ${await path.exists()}");
//     if ((await path.exists())) {
//       print("DDDDDDDD ${await path.exists()}");
//       // TODO:
//       Provider.of<ProviderData>(context, listen: false).updateQRImage(
//         ctx: context,
//         image:
//             Image.file(File("/storage/emulated/0/download_barcode/image.png",),fit: BoxFit.fill),
//       );
//     } else {
//       Provider.of<ProviderData>(context, listen: false).updateQRImage(
//           ctx: context,
//           image: Image.asset(
//             'assets/QR.png',
//             height: MediaQuery.of(context).size.height * 0.35,
//             fit: BoxFit.fill,
//           ));
//     }
//   }
//
//   void initState() {
//     //TODO get state of user from dataBase before run the app
//     // Provider.of<ProviderData>(context,
//     //                                             listen: false)
//     //                                         .changeState(true);
//     //TODO check if qr generate path exist or note
//     loadQrImage();
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BackdropScaffold(
//       frontLayerBackgroundColor: Color(0xFF162A49),
//       backgroundColor: Colors.white,
//       appBar: BackdropAppBar(
//         leading: BackdropToggleButton(
//           color: Color(0xFF162A49),
//         ),
//         iconTheme: IconThemeData(
//           color: Color(0xFF162A49),
//         ),
//         title: Header(),
//         backgroundColor: Colors.white,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: IconButton(
//               icon: Icon(
//                 Icons.help_center,
//                 size: 30,
//               ),
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//       backLayer: BackLayer(),
//       frontLayer: FrontLayer(),
//     );
//   }
// }
//
// class Header extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 32),
//       child: Text(
//         'Scan Your Barcode',
//         style: TextStyle(
//           color: Color(0xFF162A49),
//           fontSize: 22,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }
