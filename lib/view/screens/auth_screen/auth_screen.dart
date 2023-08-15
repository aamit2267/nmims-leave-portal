import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:nmims_leave_portal/view/screens/home_screen/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = true;
  final auth = FirebaseAuth.instance;

  Future<void> signIn(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on Exception catch (e) {
      if (e.toString() ==
          '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
        Fluttertoast.showToast(msg: 'User not found');
      } else if (e.toString() ==
          '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
        Fluttertoast.showToast(msg: 'Wrong password');
      } else {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Image.asset(
                  'assets/nmims_logo.png',
                  height: 100,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 50,
                  ),
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(43),
                    color: ColorConstants.offwhite,
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.black.withOpacity(0.25),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 42,
                        ),
                        child: Text(
                          "LEAVE PORTAL LOGIN",
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 37,
                          left: 16,
                          right: 16,
                        ),
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Username/SAP ID',
                            prefixIcon: const Icon(
                              Icons.alternate_email,
                              color: ColorConstants.disabledText,
                            ),
                            labelStyle: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.disabledText,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 32,
                          left: 16,
                          right: 16,
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _isPasswordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: ColorConstants.disabledText,
                            ),
                            suffixIcon: IconButton(
                              padding: const EdgeInsets.only(
                                right: 10,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                (_isPasswordVisible)
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorConstants.disabledText,
                              ),
                            ),
                            labelStyle: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.disabledText,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              final result =
                                  await InternetAddress.lookup('google.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {}
                            } on SocketException catch (_) {
                              Fluttertoast.showToast(
                                msg: 'Please check your internet connection',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorConstants.mehroon,
                                textColor: ColorConstants.white,
                                fontSize: 16.0,
                              );
                              return;
                            }
                            if (_usernameController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: 'Please fill all the fields',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorConstants.mehroon,
                                textColor: ColorConstants.white,
                                fontSize: 16.0,
                              );
                            } else {
                              try {
                                signIn(
                                  '${_usernameController.text}@nmims.com',
                                  _passwordController.text,
                                ).then((value) => {
                                      if (auth.currentUser != null)
                                        {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  const HomeScreen(),
                                              transitionDuration:
                                                  const Duration(seconds: 0),
                                            ),
                                          ),
                                        }
                                    });
                              } catch (e) {
                                Fluttertoast.showToast(
                                  msg: 'Invalid Credentials',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorConstants.mehroon,
                                  textColor: ColorConstants.white,
                                  fontSize: 16.0,
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.mehroon,
                            minimumSize: const Size(168, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
