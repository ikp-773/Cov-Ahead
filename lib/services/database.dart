import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_qrcode_bfh/models/customer.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid = ''});

  final CollectionReference<Map<String, dynamic>> customer =
      FirebaseFirestore.instance.collection('customers');
      

  Future updateUserData(
      {String name,
      String address,
      String mail,
      String pinCode,
      String phoneNum,
      int vaccineStatus}) async {
    await customer.doc(uid).set({
      'name': name,
      'address': address,
      'mail': mail,
      'pincode': pinCode,
      'phoneNum': phoneNum,
      'vaccine_stat': vaccineStatus,
    });
  }

  List<CustomerDataModel> _customerListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
      return CustomerDataModel(
          name: doc.data()['name'] ?? '',
          mail: doc.data()['mail'] ?? '',
          address: doc.data()['address'] ?? '',
          pinCode: doc.data()['pincode'] ?? '',
          phoneNum: doc.data()['phoneNum'] ?? '',
          vaccineStatus: doc.data()['vaccine_stat'] ?? 0,
          );
    }).toList();
  }

  CustomerData _customerDataFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {

    return CustomerData(
      uid: uid,
      name: snapshot.data()['name'],
      mail: snapshot.data()['mail'],
      address: snapshot.data()['address'],
      pinCode: snapshot.data()['pincode'],
      phoneNum: snapshot.data()['phoneNum'],
      vaccineStatus: snapshot.data()['vaccine_stat'],
    );
  }

  
  Stream<List<CustomerDataModel>> get customerDetails {
    return customer.snapshots().map(_customerListFromSnapshot);
  }

  // For customers
  Stream<CustomerData> get customerData {
    return customer.doc(uid).snapshots().map(_customerDataFromSnapshot);
  }
}

