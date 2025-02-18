import 'package:another_flushbar/flushbar.dart';
import 'package:event_reminder/navigation.dart';
import 'package:event_reminder/screens/dashboard.dart';
import 'package:event_reminder/screens/signup.dart';
import 'package:event_reminder/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthService {
  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(Duration(seconds: 2));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SignUp(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Logged Out!',
        style: GoogleFonts.ptSerif(fontSize: 15, color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
  }

  Future<void> signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await Future.delayed(Duration(seconds: 2));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'User successfully created!',
            style: GoogleFonts.ptSerif(fontSize: 15, color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Navigate to Dashboard after showing the snackbar
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Navigation()),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'auth/weak-password') {
        message = "The provided password is too weak";
      } else if (e.code == 'email-already-in-use') {
        message = 'Account already exists with the provided email.';
      } else {
        message = e.message ?? 'An unknown error occurred';
      }

      print('Firebase Auth Error: ${e.code}, $message');

      Flushbar(
        titleText: Text(
          "Signup Failed!",
          style: GoogleFonts.ptSerif(fontSize: 20, color: EventColors.white),
        ),
        messageText: Text(
          message,
          style: GoogleFonts.ptSerif(fontSize: 15, color: EventColors.white),
        ),
        duration: Duration(milliseconds: 1500),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: Colors.red,
        borderRadius: BorderRadius.all(Radius.elliptical(20, 25)),
        flushbarStyle: FlushbarStyle.FLOATING,
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
      ).show(context);
    }
  }

  Future<void> signin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(Duration(seconds: 2));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'User Logged in!',
            style: GoogleFonts.ptSerif(fontSize: 15, color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Navigation(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'auth/user-not-found') {
        message = "No user found linked with that email";
      } else if (e.code == 'invalid-credential') {
        message = 'Oops ! Wrong User Credentials.';
      } else {
        message = e.message ?? 'An unknown error occurred';
      }

      print('Firebase Auth Error: ${e.code}, $message');

      Flushbar(
        titleText: Text(
          "Login Failed !",
          style: GoogleFonts.ptSerif(fontSize: 20, color: EventColors.white),
        ),
        messageText: Text(
          message,
          style: GoogleFonts.ptSerif(fontSize: 15, color: EventColors.white),
        ),
        duration: Duration(milliseconds: 1500),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: Colors.red,
        flushbarStyle: FlushbarStyle.FLOATING,
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
      ).show(context);
    }
  }
}
