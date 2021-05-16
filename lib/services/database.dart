import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_qrcode_bfh/models/customer.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference customerList =
      FirebaseFirestore.instance.collection('customers');

  Future updateUserData(
      String name, streetAddress, String state, String postalCode) async {
    await customerList.doc(uid).set({
      'name': name,
      'street_address': streetAddress,
      'state': state,
      'postal_code': postalCode
    });
  }

  List<CustomerDataModel> _customerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CustomerDataModel(
          // name: doc.data()['name'] ?? '',

          );
    }).toList();
  }

  CustomerData _customerDataFromSnapshot(DocumentSnapshot snapshot) {
    return CustomerData(
      uid: uid,
      // name: snapshot.data()['name'],
    );
  }

  Stream<List<CustomerDataModel>> get customerDetails {
    return customerList.snapshots().map(_customerListFromSnapshot);
  }

  Stream<CustomerData> get customerData {
    return customerList.doc(uid).snapshots().map(_customerDataFromSnapshot);
  }
}
