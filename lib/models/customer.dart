class CustomerData {
  final String uid;
  final String name;
  final String mail;
  final String phoneNum;
  final String address;
  final String pinCode;
  final int vaccineStatus; //0-Not Vaccinated 1-Partial, 2- Fully,
  final bool covidStatas;
  CustomerData(
      {this.uid,
      this.vaccineStatus,
      this.covidStatas,
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
  final int vaccineStatus; //0-Not Vaccinated 1-Partial, 2- Fully,
  final bool covidStatas;

  CustomerDataModel({
    this.address,
    this.mail,
    this.name,
    this.phoneNum,
    this.pinCode,
    this.vaccineStatus,
    this.covidStatas,
  });
}

class PlacesVisited {
  final String storeName;
  final DateTime timestamp;

  PlacesVisited({this.storeName, this.timestamp});
}
