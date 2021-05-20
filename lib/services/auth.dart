import 'package:covid_qrcode_bfh/models/user.dart';
import 'package:covid_qrcode_bfh/services/customer_database.dart';
import 'package:covid_qrcode_bfh/services/merchant_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  UserModel _userFromFireBase(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map((User user) => _userFromFireBase(user));
  }

  Future signUpUsingEmail(email, password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      DatabaseService(uid: user.uid).updateUserData(
        name: user.displayName ?? '',
        phoneNum: user.phoneNumber ?? '',
        mail: user.email,
        pinCode: '',
        address: '',
        vaccineStatus: 0,
      );
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Since same method is used for both merch and customer
  Future signInUsingGoogle({bool isCustomer}) async {
    try {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = await _auth.signInWithCredential(authCredential);
      User user = result.user;
      isCustomer
          ? DatabaseService(uid: user.uid).checkUserData(
              name: user.displayName ?? '',
              mail: user.email,
              phoneNum: user.phoneNumber ?? '',
            )
          : MerchDatabaseService(uid: user.uid).checkUserData(
              merchantName: user.displayName ?? '',
              mail: user.email,
              phoneNum: user.phoneNumber ?? '',
            );
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInUsingMail(email, password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void signOut() async {
    try {
      await googleSignIn.signOut();
      _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
