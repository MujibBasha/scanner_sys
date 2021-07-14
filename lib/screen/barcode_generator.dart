import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:scanner_qr_sys/service/database.dart';
import 'package:scanner_qr_sys/tools/useful_tool.dart';
import 'package:circular_countdown/circular_countdown.dart';

class BarcodeGenerator extends StatefulWidget {
  @override
  _BarcodeGeneratorState createState() => _BarcodeGeneratorState();
}

class _BarcodeGeneratorState extends State<BarcodeGenerator> {
  TextEditingController controller = TextEditingController();

  Timer timer;
  String pas;

  Future<void> getPassword() async {
    pas = generatePassword();
    await DataBase().updatePassword(password: pas);
  }

  @override
  void initState() {
    getPassword();
    print(pas);
    timer = Timer.periodic(
      Duration(hours: 1),
      (timer) async {
        print("call");
        getPassword();
        print(pas);

        setState(() {});
      },
    );

    // try {
    //
    //
    // } catch (e) {
    //   print(e);
    //   setState(() {
    //
    //   });
    // }
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
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(right: 15, left: 15, top: 38, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // _mainScaffoldKey.currentState.openEndDrawer();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.sort,
                          size: 28,
                          color: Color(0XFF4daa9d),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 28,
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.filter_list,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                elevation: 10,
                shadowColor: Color(0XFFcbead6),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: pas == null
                      ? CircularProgressIndicator()
                      : BarcodeWidget(
                          data: pas,
                          barcode: Barcode.qrCode(),
                          width: 300,
                          height: 300,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:23.0),
                child: Card(
                  shadowColor: Colors.greenAccent,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99.0),
                  ),
                  child: Container(
                    width: 200,
                    height: 200,
                    child: TimeCircularCountdown(
                      repeat: true,
                      // countdownCurrentColor: Colors.greenAccent,
                      countdownRemainingColor: Color(0XFFcbead6),
                      countdownTotalColor: Color(0XFF4daa9d),
                      unit: CountdownUnit.hour,
                      countdownTotal: 1,
                      onUpdated: (unit, remainingTime) =>null,// setState((){print('Updated');}),
                      onFinished: () => print('Countdown finished'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
