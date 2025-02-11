import 'package:event_reminder/firebase/auth.dart';
import 'package:event_reminder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _obscuretext = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController econtroller = TextEditingController();
  TextEditingController pcontroller = TextEditingController();
  String? errorMessage = "";
  bool isLogin = true;

  @override
  void dispose() {
    econtroller.dispose();
    pcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: EventColors.bg),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(25),
                  child: TextFormField(
                    controller: econtroller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(20, 20),
                          bottomRight: Radius.elliptical(20, 20),
                        ),
                        borderSide: BorderSide(
                            width: 3, color: EventColors.tertiarygreen),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(20, 20),
                          bottomRight: Radius.elliptical(20, 20),
                        ),
                        borderSide: BorderSide(
                            width: 2, color: EventColors.tertiarygreen),
                      ),
                      prefixIcon: Icon(
                        Icons.mail,
                        color: EventColors.tertiarygreen,
                      ),
                      hintText: 'Email',
                      hintStyle: GoogleFonts.ptSerif(
                        color: EventColors.tertiarygreen,
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
                        color: EventColors.tertiarygreen,
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
                        fontSize: 20.0, color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await AuthService().signin(
                        email: econtroller.text,
                        password: pcontroller.text,
                        context: context);
                  },
                  style: ButtonStyle(
                    maximumSize: WidgetStatePropertyAll(Size(200, 40)),
                    backgroundColor:
                        WidgetStatePropertyAll(EventColors.tertiarygreen),
                  ),
                  child: Text(
                    'Log In',
                    style: GoogleFonts.ptSerif(
                        color: EventColors.white, fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
