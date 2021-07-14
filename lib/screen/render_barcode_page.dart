import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner_qr_sys/constants.dart';
//import 'package:share/share.dart';
import 'package:printing/printing.dart';
//
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
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

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();

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
    final File file = await new File('${tempDir.path}/image.png').create();
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
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     top: _topSectionTopPadding,
                    //     left: 20.0,
                    //     right: 10.0,
                    //     bottom: _topSectionBottomPadding,
                    //   ),
                    //   child:  Container(
                    //     height: _topSectionHeight,
                    //     child:  Row(
                    //       mainAxisSize: MainAxisSize.max,
                    //       crossAxisAlignment: CrossAxisAlignment.stretch,
                    //       children: <Widget>[
                    //         Expanded(
                    //           child:  TextField(
                    //             controller: _textController,
                    //             decoration:  InputDecoration(
                    //               hintText: "Enter a custom message",
                    //               errorText: _inputErrorText,
                    //             ),
                    //           ),
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.only(left: 10.0),
                    //           child:  InkWell(
                    //             child:  Text("SUBMIT"),
                    //             onTap: () {
                    //               setState((){
                    //                 _dataString = _textController.text;
                    //                 _inputErrorText = null;
                    //               });
                    //             },
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      width: size.width * 0.9,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
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
                            color: Colors.grey.shade900,
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
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 10),
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: 15, vertical: 5),
                    //   width: size.width * 0.9,
                    //
                    //   child: TextFormField(
                    //     obscureText: true,
                    //     style: TextStyle(
                    //       color: Colors.black45,
                    //     ),
                    //     validator: (value) {
                    //       var newValue = value.trimLeft();
                    //       if (newValue.isEmpty) {
                    //         return "this section is required";
                    //       } else if (newValue.length != 12) {
                    //         return "this section is required,Please Provide ID number with 12 character";
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     // // onChanged: onChanged,
                    //     controller: nationalIDController,
                    //     keyboardType: TextInputType.text,
                    //     cursorColor: kPrimaryColor,
                    //
                    //     decoration: new InputDecoration(
                    //       icon: Icon(Entypo.newsletter,color: Colors.grey.shade900,),
                    //       labelText: "National ID",
                    //
                    //       fillColor: Colors.black,
                    //       border: new OutlineInputBorder(
                    //
                    //         borderRadius: new BorderRadius.circular(25.0),
                    //         borderSide: new BorderSide(
                    //
                    //           color: Colors.white70,
                    //           // style:
                    //
                    //         ),
                    //       ),
                    //       //fillColor: Colors.green
                    //     ),
                    //   ),
                    // ),
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
                            color: Colors.grey.shade900,
                          ),
                          labelText: "ID Card Number",
//focusColor: Colors.grey.shade900,
//                                 hoverColor:Colors.green ,
//                                 focusColor: Colors.yellowAccent,
//

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
                        controller: idCardNumberController,
                        keyboardType: TextInputType.text,
                        cursorColor: kPrimaryColor,
                        decoration: new InputDecoration(
                          icon: Icon(
                            Icons.credit_card_outlined,
                            color: Colors.grey.shade900,
                          ),
                          labelText: "ID Card Number",
//focusColor: Colors.grey.shade900,
//                                 hoverColor:Colors.green ,
//                                 focusColor: Colors.yellowAccent,
//

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
//                     Container(
//                       margin: EdgeInsets.symmetric(vertical: 20),
//                       width: size.width * 0.9,
//                       child: TextFormField(
//                         style: TextStyle(
//                           color: Colors.black45,
//                         ),
//                         validator: (value) {
//                           var newValue = value.trimLeft();
//                           if (newValue.isEmpty) {
//                             return "this section is required";
//                           } else if (newValue.length < 4) {
//                             return "this section is required,Please Provide Id Card Number  with 4+ character";
//                           } else {
//                             return null;
//                           }
//                         },
//                         // // onChanged: onChanged,
//                         controller: idCardNumberController,
//                         keyboardType: TextInputType.text,
//                         cursorColor: kPrimaryColor,
//                         decoration: new InputDecoration(
//                           icon: Icon(
//                             Icons.credit_card_outlined,
//                             color: Colors.grey.shade900,
//                           ),
//                           labelText: "ID Card Number",
// //focusColor: Colors.grey.shade900,
// //                                 hoverColor:Colors.green ,
// //                                 focusColor: Colors.yellowAccent,
// //
//
//                           fillColor: Colors.black,
//                           border: new OutlineInputBorder(
//                             borderRadius: new BorderRadius.circular(25.0),
//                             borderSide: new BorderSide(
//                               color: Colors.teal,
//                               // style:
//                             ),
//                           ),
//                           //fillColor: Colors.green
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(vertical: 20),
//                       width: size.width * 0.9,
//                       child: TextFormField(
//                         style: TextStyle(
//                           color: Colors.black45,
//                         ),
//                         validator: (value) {
//                           var newValue = value.trimLeft();
//                           if (newValue.isEmpty) {
//                             return "this section is required";
//                           } else if (newValue.length < 4) {
//                             return "this section is required,Please Provide Id Card Number  with 4+ character";
//                           } else {
//                             return null;
//                           }
//                         },
//                         // // onChanged: onChanged,
//                         controller: idCardNumberController,
//                         keyboardType: TextInputType.text,
//                         cursorColor: kPrimaryColor,
//                         decoration: new InputDecoration(
//                           icon: Icon(
//                             Icons.credit_card_outlined,
//                             color: Colors.grey.shade900,
//                           ),
//                           labelText: "ID Card Number",
// //focusColor: Colors.grey.shade900,
// //                                 hoverColor:Colors.green ,
// //                                 focusColor: Colors.yellowAccent,
// //
//
//                           fillColor: Colors.black,
//                           border: new OutlineInputBorder(
//                             borderRadius: new BorderRadius.circular(25.0),
//                             borderSide: new BorderSide(
//                               color: Colors.teal,
//                               // style:
//                             ),
//                           ),
//                           //fillColor: Colors.green
//                         ),
//                       ),
//                     ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,right:20.0,bottom: 40),
                      child: Material(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(32),
                        child: InkWell(
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
