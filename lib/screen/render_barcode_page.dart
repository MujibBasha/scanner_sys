import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner_qr_sys/constants.dart';
//import 'package:share/share.dart';
import 'package:printing/printing.dart';
//
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:scanner_qr_sys/service/database.dart';
//

class RenderBarcodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<RenderBarcodePage> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  TextEditingController usernameController = TextEditingController();
  TextEditingController idCardNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  String customerID="Hello_from_this_QR";
  final TextEditingController _textController = TextEditingController();

  void clearTextController()
  {
    usernameController.clear();
    idCardNumberController.clear();
    phoneNumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.archive_outlined,
            color: Colors.teal,
          ),
          onPressed: _captureAndSharePng,
        ),
        elevation: 0,
        shadowColor: Color(0XFFcbead6),
        backgroundColor: Color(0XFFcbead6),
        //title: RichText( ),),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.print,
              color: Colors.teal,
            ),
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: _contentWidget(size),
    );
  }

  Future<void> _captureAndSharePng() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    var image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final File file = await new File('${tempDir.path}/$customerID.png').create();
    await file.writeAsBytes(pngBytes);

    final loadImage = pw.MemoryImage(
      file.readAsBytesSync(),
    );

    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a6,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(loadImage),
          ); // Center
        }));
    await Printing.layoutPdf(
      name: customerID,
        format: PdfPageFormat.a6,
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  _contentWidget(Size size) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0XFFcbead6),
      child: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 83.0, vertical: 5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                shadowColor: Colors.greenAccent,
                elevation: 16,
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImage(
                    data: _dataString,
                    size: 0.3 * bodyHeight,
                  ),
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: Form(
                    child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      width: size.width * 0.9,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.black45,
                        ),
                        validator: (value) {
                          var newValue = value.trimLeft();
                          if (newValue.isEmpty) {
                            return "Please Provide a valid  name";
                          } else if (newValue.length < 4) {
                            return "Please Provide  name with 4+ character";
                          } else {
                            return null;
                          }
                        },
                        // // onChanged: onChanged,
                        controller: usernameController,
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          icon: Icon(
                            Icons.perm_identity_outlined,
                            color: Color(0XFFcbead6), //Colors.grey.shade900,
                          ),
                          labelText: "username",

                          fillColor: Colors.black,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                              color: Colors.white70,
                              // style:
                            ),
                          ),
                          //fillColor: Colors.green
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: size.width * 0.9,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.black45,
                        ),
                        validator: (value) {
                          var newValue = value.trimLeft();
                          if (newValue.isEmpty) {
                            return "this section is required";
                          } else if (newValue.length < 4) {
                            return "this section is required,Please Provide Id Card Number  with 4+ character";
                          } else {
                            return null;
                          }
                        },
                        // // onChanged: onChanged,
                        controller: idCardNumberController,
                        keyboardType: TextInputType.text,
                        cursorColor: kPrimaryColor,
                        decoration: new InputDecoration(
                          icon: Icon(
                            Icons.credit_card_outlined,
                            color: Color(0XFFcbead6), // Colors.grey.shade900,
                          ),
                          labelText: "ID Card Number",
          fillColor: Colors.black,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                              color: Colors.teal,
                              // style:
                            ),
                          ),
                          //fillColor: Colors.green
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: size.width * 0.9,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.black45,
                        ),
                        validator: (value) {
                          var newValue = value.trimLeft();
                          if (newValue.isEmpty) {
                            return "this section is required";
                          } else if (newValue.length < 4) {
                            return "this section is required,Please Provide Id Card Number  with 4+ character";
                          } else {
                            return null;
                          }
                        },
                        // // onChanged: onChanged,
                        controller: phoneNumberController,
                        keyboardType: TextInputType.text,
                        cursorColor: kPrimaryColor,
                        decoration: new InputDecoration(
                          icon: Icon(
                            Icons.contact_phone,
                            color: Color(0XFFcbead6),
                          ),
                          labelText: "Phone Number",
                          fillColor: Colors.black,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                              color: Colors.teal,
                              // style:
                            ),
                          ),
                          //fillColor: Colors.green
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 40),
                      child: Material(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(32),
                        child: InkWell(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            DateTime date =
                                DateTime.now().add(Duration(hours: 1));


                            Map<String, Object> customerData = {
                              "name": usernameController.text,
                              "phone_number": phoneNumberController.text,
                              "id_card_number": idCardNumberController.text,
                              "date":"${DateFormat('M/d/y').format(date)}",
                            };

 customerID="${usernameController.text}_${idCardNumberController.text}";

                            await DataBase()
                                .addCustomerInfo(
                                    customerInfoMap: customerData,
                                    customerId:customerID??"SDsds90ieijo3j",
                                        )
                                .then((state) {
                             if(state){
                               setState(() {
                                 _dataString = customerID;
                                 AwesomeDialog(
                                   btnOkColor: Color(0XFFcbead6),// Colors.black,
                                   dialogBackgroundColor: Colors.white,
                                   dismissOnTouchOutside: false,
                                   isDense: true,
                                   context: context,
                                   dialogType: DialogType.SUCCES,
                                   animType: AnimType.BOTTOMSLIDE,
                                   title: 'Success',
                                   desc: 'QR Code is Created successful',
                                   btnOkIcon: Icons.local_print_shop_outlined,
                                   btnOkText: "print QR",
                                   btnOkOnPress: () {
                                     clearTextController();
                                     Navigator.pop(context);
                                     _captureAndSharePng();
                                   },
                                 )..show();

                               });
                             }else{
                               AwesomeDialog(
                                 btnOkColor: Colors.redAccent,// Colors.black,
                                 dialogBackgroundColor: Colors.white,
                                 dismissOnTouchOutside: false,
                                 isDense: true,
                                 context: context,
                                 dialogType: DialogType.ERROR,
                                 animType: AnimType.BOTTOMSLIDE,
                                 title: 'Error',
                                 desc: 'Please Try again',
                                 btnOkIcon: Icons.local_print_shop_outlined,
                                 btnOkText: "ok",
                                 btnOkOnPress: () {
                                   clearTextController();
                                   Navigator.pop(context);

                                 },
                               )..show();
                             }
                            });
                          },
                          borderRadius: BorderRadius.circular(32),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Center(child: Text("Generate")),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))),
          ],
        ),
      ),
    );
  }
}
