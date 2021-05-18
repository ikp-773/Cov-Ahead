import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_qrcode_bfh/models/merchant.dart';

class MerchDatabaseService {
  final String uid;
  MerchDatabaseService({this.uid = ''});

  final CollectionReference<Map<String, dynamic>> merchant =
      FirebaseFirestore.instance.collection('merchants');

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
}
