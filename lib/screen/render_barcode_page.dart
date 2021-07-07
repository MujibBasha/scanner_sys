import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:scanner_qr_sys/service/database.dart';
import 'package:scanner_qr_sys/tools/useful_tool.dart';

class RenderBarcodePage extends StatefulWidget {


  @override
  _RenderBarcodePageState createState() => _RenderBarcodePageState();
}

class _RenderBarcodePageState extends State<RenderBarcodePage> {
  TextEditingController controller = TextEditingController();


  Timer timer;
  String pas="hdsgvu26t6t#@";

  @override
  void initState() {
    try {

      timer = Timer.periodic(
        Duration(seconds: 30),
            (timer)async {
          setState(() {
            print("call");
            pas= generatePassword();
            print(pas);

          });
          await DataBase().updatePassword(password:pas );

        },
      );
    } catch (e) {
      print(e);
      setState(() {

      });
    }
    super.initState();
  }

  @override
  void dispose() {
    print("dispose");
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView (
          child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Card(
            elevation: 6,
            shadowColor: Colors.orangeAccent,
            color:Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BarcodeWidget(
                data: pas,
                barcode: Barcode.qrCode(),
                width: 350,
                height: 350,
              ),
            ),
          ),

      ],
    ),
        ));
  }

  Widget buildTextField(BuildContext ctx) {
    return TextField(

      controller: controller,
      decoration: InputDecoration(
        hintText: "add data",
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.assignment_turned_in_outlined,
              color: Colors.deepOrange),
          onPressed: () {
            setState(() {});
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
