import 'package:event_reminder/firebase/auth.dart';
import 'package:event_reminder/navigation.dart';
import 'package:event_reminder/utils/colors.dart';
import 'package:event_reminder/utils/page_utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool _obscurepassword = true;
  // final _formKey = GlobalKey<FormState>();
  // TextEditingController econtroller = TextEditingController();
  // TextEditingController pcontroller = TextEditingController();
  String? errorMessage = "";
  bool isLogin = true;
  bool _rememberMe = false;
  bool isExpanded = false;

  @override
  late Animation<double> logofadeopacity;
  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    logofadeopacity = Tween<double>(begin: 0, end: 1).animate(controller);
    slideAnimation = Tween(begin: Offset(-1, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    scaleAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    controller.forward();
  }

  // Load "Remember Me" state from SharedPreferences
  Future<void> _loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Navigation()));
      });
    } else {
      setState(() {
        _rememberMe = prefs.getBool('rememberMe') ?? false;
        if (_rememberMe) {
          FormUtils.usernameController.text = prefs.getString('username') ?? '';
          FormUtils.passwordController.text = prefs.getString('password') ?? '';
        }
      });
    }
  }

  // Save "Remember Me" state to SharedPreferences
  Future<void> _saveRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      prefs.setBool('rememberMe', true);
      prefs.setString('username', FormUtils.usernameController.text);
      prefs.setString('password', FormUtils.passwordController.text);
    } else {
      prefs.setBool('rememberMe', false);
      prefs.remove('username');
      prefs.remove('password');
    }
  }

  // Save login state to SharedPreferences
  Future<void> _saveLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        body: Container(
          color: EventColors.bg,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: FadeTransition(
                    opacity: logofadeopacity,
                    child: Text('Welcome Back,',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 30)),
                  ),
                ),
                SizedBox(height: 45),
                FadeTransition(
                  opacity: logofadeopacity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 40.0),
                    child: Text(
                        'Discover Limitless Choices and Unmatched Convenience !!',
                        style: TextStyle(fontSize: 22)),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SlideTransition(
                        position: slideAnimation,
                        child: TextFormField(
                          controller: FormUtils.usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(color: EventColors.textcolor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.elliptical(20, 20),
                                bottomLeft: Radius.elliptical(20, 20),
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
                            prefixIcon: Icon(Icons.person_outlined,
                                color: EventColors.tertiarygreen),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SlideTransition(
                        position: slideAnimation,
                        child: TextFormField(
                          controller: FormUtils.passwordController,
                          obscureText: _obscurepassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: EventColors.textcolor),
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
                                  width: 2, color: EventColors.tertiarygreen),
                            ),
                            prefixIcon: Icon(Icons.password,
                                color: EventColors.tertiarygreen),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurepassword = !_obscurepassword;
                                });
                              },
                              icon: _obscurepassword
                                  ? Icon(Icons.visibility,
                                      color: EventColors.tertiarygreen)
                                  : Icon(Icons.visibility_off,
                                      color: EventColors.tertiarygreen),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Checkbox(
                            checkColor: EventColors.white,
                            activeColor: EventColors.tertiarygreen,
                            overlayColor: WidgetStatePropertyAll(
                                EventColors.tertiarygreen),
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                        ),
                        Text('Remember Me', style: TextStyle(fontSize: 18)),
                        SizedBox(width: 45),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: EventColors.tertiarygreen, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 2000),
                          curve: Curves.easeInOut,
                          child: ElevatedButton(
                            onPressed: () async {
                              await AuthService().signin(
                                  email: FormUtils.usernameController.text,
                                  password: FormUtils.passwordController.text,
                                  context: context);
                            },
                            style: ButtonStyle(
                              maximumSize:
                                  WidgetStatePropertyAll(Size(200, 40)),
                              backgroundColor: WidgetStatePropertyAll(
                                  EventColors.tertiarygreen),
                            ),
                            child: Text(
                              'Log In',
                              style: GoogleFonts.ptSerif(
                                  color: EventColors.white, fontSize: 18),
                            ),
                          )),
                    ),
                    SizedBox(height: 20),
                    // Text("")
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
