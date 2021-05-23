class MerchantModel {
  final String uid;
  MerchantModel({this.uid});
}

class MerchantData {
  final String uid;
  final String merchantName;
  final String shopName;
  final String mail;
  final String phoneNum;
  final String address;
  final String pinCode;
  MerchantData(
      {this.uid,
      this.merchantName,
      this.shopName,
      this.address,
      this.mail,
      this.phoneNum,
      this.pinCode});
}

class MerchantDataModel {
  final String shopName;
  final String mail;
  final String phoneNum;
  final String address;
  final String pinCode;

  MerchantDataModel(
      {this.address, this.mail, this.shopName, this.phoneNum, this.pinCode});
}

class MerchantVisitorLog {
  final String customerName;
  final DateTime timestamp;
  final String mail;
  final String phoneNum;

  MerchantVisitorLog(
      {this.customerName, this.timestamp, this.mail, this.phoneNum});
}
