import 'package:covid_qrcode_bfh/models/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  CustomerModel _userFromFireBase(User user) {
    return user != null ? CustomerModel(uid: user.uid) : null;
  }

  Stream<CustomerModel> get user {
    return _auth.authStateChanges().map((User user) => _userFromFireBase(user));
  }

  Future signUpUsingEmail(email, password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
  //   DatabaseService(uid: user.uid).updateUserData('', '', '', '');
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInUsingGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = await _auth.signInWithCredential(authCredential);
      User user = result.user;
     // DatabaseService(uid: user.uid).updateUserData('', '', '', '');
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

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
