import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scanner_qr_sys/service/database.dart';
import 'package:scanner_qr_sys/api/sheets/user_sheets_api.dart';
import 'package:scanner_qr_sys/sheet_model/user.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  DocumentSnapshot userData;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
      ),
      body: QRView(

        cameraFacing: CameraFacing.back,
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        formatsAllowed: [BarcodeFormat.qrcode],
        overlay:QrScannerOverlayShape(borderColor: Colors.blueAccent) ,
overlayMargin: EdgeInsets.only(left: 12),
      ),
    );
  }

Future<DocumentSnapshot> checkUser({bool isCustomer,response})async{
  return await DataBase().getEmployeeInfo(isEmployee:!isCustomer,userId: response.code );
}

Future<bool> updateWorkSheet(User newUser)async{
  await UserSheetsApi.init( userData:newUser.toJson() );
}

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(( scanData) async {
      controller.pauseCamera();

      if (scanData != null ) {

        userData=await checkUser(isCustomer:scanData.code.contains("cus"),response:scanData);

print("__________________333333_____");
print( userData.data());
        User newUser=User(id: userData.get("id")??"",name:  userData.get("username")??"",
            email:userData.get("email")??"" ,cardID: userData.get("id_card_number")??"" );

        await updateWorkSheet(newUser);

     //   print('Data: ${scanData.code}');
        controller.toString();
        controller.stopCamera();

      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Could not find viable url'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Barcode Type:'),// ${describeEnum(scanData.format)
                    Text('Data: ${scanData.code}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }
}