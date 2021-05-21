import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_qrcode_bfh/models/merchant.dart';
import 'package:covid_qrcode_bfh/services/customer_database.dart';
import 'package:flutter/material.dart';

class MerchDatabaseService {
  final String uid;
  MerchDatabaseService({this.uid = ''});

  final CollectionReference<Map<String, dynamic>> merchant =
      FirebaseFirestore.instance.collection('merchants');

  Future checkUserData({
    String merchantName,
    String mail,
    String phoneNum,
  }) async {
    var checkMerch = await merchant.doc(uid).get();
    if (!checkMerch.exists) {
      updateUserData(
          merchantName: merchantName,
          phoneNum: phoneNum ?? '',
          mail: mail,
          pinCode: '',
          address: '',
          shopName: '');
    }
  }

  Future updateUserData({
    String merchantName,
    String shopName,
    String address,
    String mail,
    String pinCode,
    String phoneNum,
  }) async {
    await merchant.doc(uid).set({
      'merchantName': merchantName,
      'shopName': shopName,
      'address': address,
      'mail': mail,
      'pincode': pinCode,
      'phoneNum': phoneNum,
    });
  }

  List<MerchantDataModel> _merchantListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
      return MerchantDataModel(
        shopName: doc.data()['shopName'] ?? '',
        mail: doc.data()['mail'] ?? '',
        address: doc.data()['address'] ?? '',
        pinCode: doc.data()['pincode'] ?? '',
        phoneNum: doc.data()['phoneNum'] ?? '',
      );
    }).toList();
  }

  MerchantData _merchantDataFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return MerchantData(
      uid: uid,
      merchantName: snapshot.data()['merchantName'],
      shopName: snapshot.data()['shopName'],
      mail: snapshot.data()['mail'],
      address: snapshot.data()['address'],
      pinCode: snapshot.data()['pincode'],
      phoneNum: snapshot.data()['phoneNum'],
    );
  }

  Stream<List<MerchantDataModel>> get merchantDetails {
    return merchant.snapshots().map(_merchantListFromSnapshot);
  }

  // For customers
  Stream<MerchantData> get merchantData {
    return merchant.doc(uid).snapshots().map(_merchantDataFromSnapshot);
  }

  Stream<List<MerchantVisitorLog>> get visitorsLog {
    return merchant
        .doc(uid)
        .collection('visitorsLog')
        .snapshots()
        .map(_visitorsLogGeneration);
  }

  // On succesfull QR code scanning, verification done here
  Future<bool> isMerchantPresent({String customerUID}) async {
    bool returnVal = false;
    QuerySnapshot<Map<String, dynamic>> querySnap = await merchant.get();
    querySnap.docs.forEach((queryDocSnap) async {
      // Comparing with all merchant uid
      if (queryDocSnap.id == uid) {
        returnVal = true;
        DatabaseService _customerDb = DatabaseService(uid: customerUID);
        DateTime _currentTime = DateTime.now();

        // Updating in customer
        _customerDb.updateVistedAreas(
          storeName: queryDocSnap.data()['shopName'],
          dateTime: _currentTime,
        );

        // Fetching customer name to add in merchant visitor log
        String customerName = await _customerDb.getCustomerName();
        addCustomerVisit(customerName: customerName, timestamp: _currentTime);
      }
    });
    return returnVal;
  }

  // Adding customer visit to visitorsLog in merchant collection
  Future<bool> addCustomerVisit(
      {String customerName, DateTime timestamp}) async {
    await merchant
        .doc(uid)
        .collection('visitorsLog')
        .doc()
        .set({'customerName': customerName, 'timestamp': timestamp});
    return true;
  }

  List<MerchantVisitorLog> _visitorsLogGeneration(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
      return MerchantVisitorLog(
          customerName: doc.data()['customerName'],
          timestamp: doc.data()['timestamp']?.toDate());
    }).toList();
  }
}
