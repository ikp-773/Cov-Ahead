class CustomerModel {
  final String uid;
  CustomerModel({this.uid});
}

class CustomerData {
  final String uid;
  final String name;
  final String mail;
  final String phoneNum;
  final String address;
  final String pinCode;
  final int vaccineStatus; //1-Not Vaccinated 2-Partial, 3- Fully,
  CustomerData(
      {this.uid,
      this.vaccineStatus,
      this.name,
      this.address,
      this.mail,
      this.phoneNum,
      this.pinCode});
}

class CustomerDataModel {
  final String name;
  final String mail;
  final String phoneNum;
  final String address;
  final String pinCode;

  CustomerDataModel(
      {this.address, this.mail, this.name, this.phoneNum, this.pinCode});
}
