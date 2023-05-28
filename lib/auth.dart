import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:notes_app/screens/updatenotescreen.dart';
import './screens/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './screens/userscreen.dart';
import './circularbar.dart';

class Authorization {
  static String? profileImage;
  static String? profileName;
  static String? uid;
  static bool fb = false;
  static bool gl = false;
  static bool pa = false;
  static String? headline;
  static String? belowline;
  static String? idofdocument;
  

  static Future<int> fbsignin(context) async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email'],
    );
    if (result.status == LoginStatus.success) {
      fb = true;
      gl = false;
      pa = false;
      final userData = await FacebookAuth.instance.getUserData();
      profileName = userData['name'];
      profileImage = userData['picture']['data']['url'];
      uid = userData['id'];
      Navigator.pushNamed(context, UserScreen.id);
    } else {
      handleError(result.message, context);
    }
    return 2;
  }

  static Future<int> fbsignout(context) async {
    await FacebookAuth.instance.logOut();
    return 2;
  }

  static Future<int> googlesignin(context) async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
          clientId:
              "947863918813-v1l9s5uvn2c65kseg190.apps.googleusercontent.com");
      final result = await _googleSignIn.signIn();
      gl = true;
      fb = false;
      pa = false;
      profileImage = result!.photoUrl;
      profileName = result.displayName;
      uid = result.id;
      Navigator.pushNamed(context, UserScreen.id);
    } catch (e) {
     
      handleError(e.toString(), context);
     
      
    }
    return 2;
  }

 

  static Future<int> googlesignout(context) async {
    await GoogleSignIn(
            clientId:
                "947863918813-v1l0.apps.googleusercontent.com")
        .signOut();
    Navigator.pop(context);
    return 2;
  }

  static Future<int> emailpasswordcreate(
      String Email, String Password, context, String fname) async {
    try {
      print(fname);
      final auth = FirebaseAuth.instance;
      final result = await auth.createUserWithEmailAndPassword(
          email: Email, password: Password);
      if (result.user != null) {
        User? user = result.user;
        user?.updateDisplayName(fname);
        Navigator.pushNamed(context, LoginScreen.id);
      } else {
        Navigator.pop(context);
        handleError("Error", context);
      }
    } catch (e) {
      Navigator.pop(context);
      handleError(e.toString(), context);
    }
    return 2;
  }

  static Future<int> emailpaswordsignin(
      String Email, String Password, context) async {
    pa = true;
    fb = false;
    gl = false;
    final auth = FirebaseAuth.instance;
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: Email, password: Password);
      if (result.user != null) 
      {
        uid = result.user!.uid;
        profileName = result.user!.displayName;
        profileImage = "https://picsum.photos/250?image=9";
        Navigator.pushNamed(context, UserScreen.id);
      } else {
        Navigator.pop(context);
        handleError("Problem while signing in", context);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      handleError(e.toString(), context);
    }
    return 2;
  }

  static Future<int> emailpasswordsignout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    return 2;
  }

  static Future<String?> handleError(error, context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert'),
        content: Text(error.toString()),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static Future<int> addff(titletext, desctext, uid) async {
    final result = FirebaseFirestore.instance;
    final message = <String, String>{
      "Title": titletext,
      "Description": desctext,
      'uid': uid,
    };
    await result.collection('notes').doc().set(message);
    return 2;
  }

  static Future<QuerySnapshot> fetchDocument(String documentId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('notes')
        .where("uid", isEqualTo: uid)
        .get();
    return snapshot;
  }

  static Future<int> opennote(
      String title, String description, context, String? docid) async {
    headline = title;
    belowline = description;
    idofdocument = docid;
    return 2;
  }

  static Future<int> updatenote(titletext, desctext, uid, idofdoc) async {
    final message = <String, String>{
      "Title": titletext,
      "Description": desctext,
      'uid': uid,
    };
    await FirebaseFirestore.instance
        .collection('notes')
        .doc(idofdoc)
        .update(message);
    return 2;
  }

  static Future<int> deletenote(idofdoc) async {
    await FirebaseFirestore.instance.collection('notes').doc(idofdoc).delete();
    return 2;
  }

  static Future<int> checklogin(idofdoc, context) async {
    if (idofdoc == null) {
      Navigator.of(context).pushNamed(LoginScreen.id);
      Authorization.handleError("You Got Logged Out", context);
    }
    return 2;
  }
}
