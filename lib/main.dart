
import 'package:flutter/material.dart';
import 'package:scanner_qr_sys/barecode_scan_page.dart';
import 'package:scanner_qr_sys/render_barcode_page.dart';
import 'package:scanner_qr_sys/scanner.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
      [
        {  "page":Container(),},
{  "page":Scanner()},

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
      bottomNavigationBar: BottomAppBar(
        child:BottomNavigationBar(
          onTap: update_pages,
          currentIndex: this.currentIndex,
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.orange,
          showSelectedLabels: true,
            showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.scanner),label: "Scanner",

            ),
            BottomNavigationBarItem(icon: Icon(Icons.drive_file_rename_outline),label: "Render"),
          ],
        )
      ),
    );

  }
}
