import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  bool _isInitialized = false;

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future<UserCredential?> googleLogin() async {
    if (!_isInitialized) {
      await googleSignIn.initialize();
      _isInitialized = true;
    }
    final googleUser = await googleSignIn.authenticate();
    _user = googleUser;
    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
    return userCredential;
  }

  Future<void> logout() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }
}
