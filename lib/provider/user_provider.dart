import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:micasa/widget/alert.dart';

class UserProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void checkUser(final BuildContext context) async {
    final _currentUser = _auth.currentUser;

    if (_currentUser != null) {
      Navigator.of(context).pushReplacementNamed("/home");
    } else {
      Navigator.of(context).pushReplacementNamed("/login");
    }
  }

  Future<String> getUUID() async {
    User user = _auth.currentUser;
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(user.uid).get();

    return snapshot.data().containsKey('uuid') ? snapshot.data()['uuid'] : null;
  }

  Future<String> getUser() async {
    User user = _auth.currentUser;
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(user.uid).get();

    return snapshot.data().containsKey('uuid') ? user.email : null;
  }

  Future userRegistration(final BuildContext context, final String _email, final String _password, final String _uuid) async {
    try {
      UserCredential credential = await _auth
          .createUserWithEmailAndPassword(
          email: _email,
          password: _password);

      _firestore
          .collection('users')
          .doc(credential.user.uid)
          .set({
        'uuid': _uuid,
      }).then((userInfoValue) {
        Navigator.of(context).pushNamed('/home');
      });
    } catch(e) {
      showAlertDialog(context, e.toString());
    }
  }

  void signIn(final BuildContext context, final String _email, final String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      Navigator.of(context).pushNamed('/home');
    } catch(e) {
      showAlertDialog(context, e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}