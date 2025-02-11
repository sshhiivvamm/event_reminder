import 'package:event_reminder/firebase/auth.dart';
import 'package:event_reminder/screens/signin.dart';
import 'package:event_reminder/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController econtroller = TextEditingController();
  TextEditingController pcontroller = TextEditingController();
  String? errorMessage = "";
  bool _obscuretext = true;

  @override
  void dispose() {
    econtroller.dispose();
    pcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: EventColors.bg),
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(25),
                child: TextFormField(
                  controller: econtroller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15.0),
                    prefixIcon: Icon(
                      Icons.mail,
                      color: EventColors.tertiarygreen,
                    ),
                    hintText: 'Email',
                    hintStyle:
                        GoogleFonts.ptSerif(color: EventColors.primarygreen),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(20, 20),
                        bottomRight: Radius.elliptical(20, 20),
                      ),
                      borderSide: BorderSide(
                          width: 2, color: EventColors.tertiarygreen),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.elliptical(20, 20),
                        bottomLeft: Radius.elliptical(20, 20),
                      ),
                      borderSide: BorderSide(
                          width: 3, color: EventColors.tertiarygreen),
                    ),
                  ),
                  style: GoogleFonts.ptSerif(
                      fontSize: 20.0, color: EventColors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: TextFormField(
                  controller: pcontroller,
                  obscureText: _obscuretext,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15.0),
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.key,
                      color: EventColors.tertiarygreen,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscuretext = !_obscuretext;
                        });
                      },
                      icon: _obscuretext
                          ? Icon(Icons.visibility_off,
                              color: EventColors.tertiarygreen)
                          : Icon(Icons.visibility,
                              color: EventColors.tertiarygreen),
                    ),
                    hintStyle: GoogleFonts.ptSerif(
                      color: EventColors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(20, 20),
                        bottomRight: Radius.elliptical(20, 20),
                      ),
                      borderSide: BorderSide(
                          width: 2, color: EventColors.tertiarygreen),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.elliptical(20, 20),
                        bottomLeft: Radius.elliptical(20, 20),
                      ),
                      borderSide: BorderSide(
                          width: 3, color: EventColors.tertiarygreen),
                    ),
                  ),
                  style: GoogleFonts.ptSerif(
                      fontSize: 20.0, color: EventColors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await AuthService().signup(
                      email: econtroller.text,
                      password: pcontroller.text,
                      context: context);
                },
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(EventColors.tertiarygreen)),
                child: Text(
                  'Sign In',
                  style: GoogleFonts.ptSerif(
                      color: EventColors.white, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Text(
                  "Already have a account? Login",
                  style: GoogleFonts.ptSerif(
                      fontSize: 18.0, color: EventColors.tertiarygreen),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
