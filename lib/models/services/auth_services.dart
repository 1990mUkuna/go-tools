import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<User> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print('Create Account Succesfully');
      await _firestore.collection('users').doc(_auth.currentUser.uid).set({
        "name": name,
        "email": email,
        "status": "Unavailable",
      });
      return user;
    } else {
      print("Accout created failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User> login(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print('Login Succesfully');
      return user;
    } else {
      print("Login Failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await _auth.signOut();
  } catch (e) {
    print("error");
  }
}
