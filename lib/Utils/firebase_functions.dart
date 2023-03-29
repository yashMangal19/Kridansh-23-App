import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  Future<bool> signInwithGoogle(String name, String hostel) async {
    try {
      bool isSignedIn = await _googleSignIn.isSignedIn();
      if(isSignedIn){
        await _googleSignIn.signOut();
      }
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential user = await _auth.signInWithCredential(credential);
      if(!user.user!.email!.endsWith("iitj.ac.in")){
        hostel = "$hostel-nonIITJ";
      }
      await _saveUserData(user.user!.uid, name, hostel);
      return true;
    } on FirebaseAuthException catch (err) {
      debugPrint(err.message);
    }
    on Exception catch(err){
      debugPrint(err.toString());
    }
    return false;
  }

  Future<void> signOutFromGoogle() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> _saveUserData(String id, String name, String hostel) async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc(id)
        .set({
          "name": name,
          "hostel": hostel
        });
  }
}