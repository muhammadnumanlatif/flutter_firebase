import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/utils.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Register user
  Future<User?> register(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Utils().customMessage(context, e.message.toString(), Colors.redAccent);
    } catch (e) {
      print(e);
    }
  }

  //login user
  Future<User?> signIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Utils().customMessage(context, e.message.toString(), Colors.redAccent);
    } catch (e) {
      print(e);
    }
  }

  //login user
  Future<User?> signOut(BuildContext context) async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      Utils().customMessage(context, e.message.toString(), Colors.redAccent);
    } catch (e) {
      print(e);
    }
  }

}
