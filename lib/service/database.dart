import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class DataBase {
  // FirebaseFirestore _fireStore;
  //
  // DataBase() {
  //   initialFirebase();
  // }
  // initialFirebase() async {
  //   // try {
  //   //await Firebase.initializeApp();
  //   _fireStore = FirebaseFirestore.instance;
  //   // } catch (e) {
  //   //   print(e);
  //   //   //show Screen
  //   // }
  // }

  Future<DocumentSnapshot> getEmployeeInfo(
      {bool isEmployee, String userId}) async {
    return FirebaseFirestore.instance
        .collection(isEmployee ? "employees" : "customers")
        .doc("$userId")
        .get(); //{userId.replaceAll("from", replace)}
  }

  Future<void> updatePassword({String password}) async {
    await FirebaseFirestore.instance
        .collection("generated_password")
        .doc("generated_password")
        .set({
      "password": "$password",
    }); //{userId.replaceAll("from", replace)}
  }


  Future<bool> addUserInfo({Map userInfoMap, String userId}) async {
    try {
      FirebaseFirestore.instance
          .collection("employees")
          .doc(userId)
          .set(userInfoMap);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addCustomerInfo({Map customerInfoMap, String customerId}) async {
    try {
      FirebaseFirestore.instance
          .collection("customers")
          .doc(customerId)
          .set(customerInfoMap);
      return true;
    } catch (e) {
      return false;
    }
  }
}
