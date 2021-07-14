
import 'package:flutter/material.dart';
import 'package:scanner_qr_sys/screen/barcode_generator.dart';
import 'package:scanner_qr_sys/screen/render_barcode_page.dart';

import 'package:scanner_qr_sys/screen/scanner.dart';
import "package:firebase_core/firebase_core.dart";


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: BottomBar(),
    );
  }
}

class BottomBar extends StatefulWidget {


  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex=0;

  List<Map<String, Widget>> _pages  =
      [  {  "page":BarcodeGenerator()},
        {  "page":Scanner()},
        {  "page":RenderBarcodePage(),},


      ];


  @override
  Widget build(BuildContext context) {
      void update_pages(int index){
        setState(() {
          currentIndex=index;
        });
    }
    return Scaffold(

      body: _pages[currentIndex]["page"],

      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(

          shadowColor: Color(0XFF4daa9d),
          elevation: 6,
          borderRadius: BorderRadius.circular(28),
          child: FloatingActionButton(

            focusColor: Color(0XFF4daa9d),
            backgroundColor: Color(0XFF4daa9d),
            tooltip: 'scanner',
            elevation: 0,
            child: Image.asset("assets/images/scann_button.jpeg",filterQuality:FilterQuality.none  ,),
            onPressed: () {
              setState(() {
                currentIndex=1;
              });
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(

          notchMargin: 6,
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
        child:Container(
          clipBehavior: Clip.antiAlias,

          height: kBottomNavigationBarHeight,
          decoration: BoxDecoration(

              border: Border(

                top: BorderSide(width: 0.7,color: Color(0XFFcbead6),),
              )),
          child: BottomNavigationBar(

            elevation: 0,
            onTap: update_pages,
            currentIndex: this.currentIndex,
            selectedItemColor: Color(0XFF4daa9d),
            unselectedItemColor: Color(0XFFcbead6),
            showSelectedLabels: true,
              showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner_outlined),
                tooltip: 'Home',
                label: 'Home',
              ),
             // BottomNavigationBarItem(icon: Icon(Icons.scanner),label: "Scanner",


              BottomNavigationBarItem(icon: Icon(null),label: "scanner"),

              BottomNavigationBarItem(icon: Icon(Icons.drive_file_rename_outline),label: "Render"),
            ],
          ),
        )
      ),
    );

  }
}

