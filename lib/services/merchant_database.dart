import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_qrcode_bfh/models/customer.dart';

class MerchantDatabaseService {
  final String uid;
  MerchantDatabaseService({this.uid});

  final CollectionReference merchantsList =
      FirebaseFirestore.instance.collection('merchants');

  Future updateUserData(
      String name, streetAddress, String state, String postalCode) async {
    await merchantsList.doc(uid).set({
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
    return merchantsList.snapshots().map(_customerListFromSnapshot);
  }

  Stream<CustomerData> get customerData {
    return merchantsList.doc(uid).snapshots().map(_customerDataFromSnapshot);
  }
}
