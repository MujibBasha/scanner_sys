import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class RenderBarcodePage extends StatefulWidget {


  @override
  _RenderBarcodePageState createState() => _RenderBarcodePageState();
}

class _RenderBarcodePageState extends State<RenderBarcodePage> {
  TextEditingController controller = TextEditingController();

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
                data: controller.text,
                barcode: Barcode.code128(),
                width: 200,
                height: 200,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          buildTextField(context),
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
