import 'dart:typed_data';

import 'package:flutter/material.dart';

class ProviderData extends ChangeNotifier {
  bool cardUserInfoState = false;

  Image qrImage;

  String dir;

  void updateQRImage({BuildContext ctx, Image image}) {
    qrImage = image;
    notifyListeners();
  }

  void changeState(bool state) {
    cardUserInfoState = state;
    notifyListeners();
  }

  Uint8List pdfFileByte;

  String userID = "";
  String officeName = "";
  String fullName = "";
  String username = "";
  String email = "";
  String inputEmail = "";
  String phoneNumber = "";
  String idNumber = "";

  String currentEntityName = "";
  List<TextEditingController> controllers = [];
  List<Map<String, String>> generalEntityInfoDocumentData = [
    // {"textField":"null", "question": null""},
  ];

  String generalApplicationPath = "";

  List<Map<String, String>> reportInfoDocumentData = [];
  int totalCurrentQuestion = 00;
  int questionStored = 0;

  void clearData() {
    generalEntityInfoDocumentData.clear();
    controllers.clear();
    notifyListeners();
  }

  changeTotal(int total) {
    totalCurrentQuestion = total;
    notifyListeners();
  }

  String resetEmail = "";
  bool playing = false;
  bool isNotified = true;
  String profileImageURL;

  Locale locale; //Locale("ar", "SA");

  void changeLocale(Locale loc) {
    // locale = loc;
    // notifyListeners();
  }

  void changeUserData({String data, String dataType}) {
    // if (dataType == "username") {
    //   username = data;
    // } else if (dataType == "email") {
    //   email = data;
    // } else if (dataType == "officeName") {
    //   officeName = data;
    // } else if (dataType == "fullName") {
    //   fullName = data;
    // } else if (dataType == "phoneNumber") {
    //   phoneNumber = data;
    // } else if (dataType == "idNumber") {
    //   idNumber = data;
    // }
    //
    // notifyListeners();
  }

  // void changeState(bool state, String typeState) {
  //   // if (typeState == "playing") {
  //   //   playing = state;
  //   // } else if (typeState == "isNotified") {
  //   //   isNotified = state;
  //   // } else if (typeState == "") {}
  //   //
  //   // notifyListeners();
  // }

  void upDateProFileImageURL(String imageURL) async {
    profileImageURL = imageURL;
    notifyListeners();
  }
}
