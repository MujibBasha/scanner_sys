//
// import 'package:flutter/material.dart';
// import 'package:scanner_qr_sys/api/sheets/user_sheets_api.dart';
// import 'package:scanner_qr_sys/sheet_model/user.dart';
//
// class CreateSheetsPage extends StatefulWidget {
//   @override
//   _CreateSheetsPageState createState() => _CreateSheetsPageState();
// }
//
// class _CreateSheetsPageState extends State<CreateSheetsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Material(
//           borderRadius: BorderRadius.circular(32),
//           color: Colors.blue,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(32),
//             onTap: () async {
//               insertUsers();
//             },
//           )),
//     ));
//   }
//
//   Future insertUsers() async {
//     final users = [
//       User(
//         id: 76257,
//         name: "Mujib basha",
//         email: "mjub451@gmail.com",
//         isBeginner: true,
//       ),
//       User(
//         id: 76257,
//         name: "Mujib basha",
//         email: "mjub451@gmail.com",
//         isBeginner: true,
//       ),
//     ];
//     final jsonUsers = users.map((user) => user.toJson()).toList();
//
//     await UserSheetsApi.insert(jsonUsers);
//   }
// }
