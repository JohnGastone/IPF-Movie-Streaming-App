// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipfmoviestreaming/HomeScreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isChecked = false;
  bool isObscured = true;
  bool isObscuredConfirm = true;

  // Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Method to handle Google Sign-In
  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          return user;
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Stack(children: [
          ImageFiltered(
            imageFilter:
                ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Apply blur here
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("./assets/backk.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 60),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.04,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 248, 248, 248),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: screenHeight * 0.02,
                        ),
                      ),
                    ),
                    Text(
                      "Skip",
                      style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 248, 248, 248)),
                    )
                  ],
                ),
                Text(
                  "Create Your Account",
                  style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 248, 248, 248)),
                ),
                SizedBox(
                  height: screenHeight * 0.158,
                ),
                Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                    child: TextField(
                      style:
                          GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Username",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.grey)),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                    child: TextField(
                      style:
                          GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.grey)),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                      child: TextField(
                        obscureText: isObscured,
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.grey),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscured = !isObscured;
                              });
                            },
                            icon: Icon(
                              isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                      child: TextField(
                        obscureText: isObscuredConfirm,
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.grey),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Confirm Password",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscuredConfirm = !isObscuredConfirm;
                              });
                            },
                            icon: Icon(
                              isObscuredConfirm
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        fillColor: WidgetStateProperty.all(
                            Color.fromARGB(255, 248, 248, 248)),
                        checkColor: Color.fromARGB(255, 142, 0, 254),
                        value: isChecked,
                        side: BorderSide(
                            color: Color.fromARGB(255, 248, 248, 248)),
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                      Text(
                        "Remember Me",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color.fromARGB(255, 248, 248, 248)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Container(
                  height: screenHeight * 0.045,
                  width: screenWidth * 0.6,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 142, 0, 254),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      )),
                  child: Center(
                    child: Text(
                      "Sign up",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.28,
                        child: Divider(
                          color: Color.fromARGB(255, 248, 248, 248),
                        )),
                    Text(
                      " Or Continue With ",
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Color.fromARGB(255, 248, 248, 248)),
                    ),
                    SizedBox(
                        width: screenWidth * 0.28,
                        child: Divider(
                          color: Color.fromARGB(255, 248, 248, 248),
                        )),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.1,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 248, 248, 248),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              height: screenHeight * 0.02,
                              width: screenWidth * 0.04,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("./assets/fb.png"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.1,
                        ),
                        Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.1,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 248, 248, 248),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: InkWell(
                              onTap: () async {
                                User? user =
                                    await _signInWithGoogle(); // This function handles the Google Sign-In
                                if (user != null) {
                                  // If the sign-in is successful, show a confirmation and navigate to HomeScreen
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Google Sign-In Successful: ${user.displayName}')),
                                  );

                                  // Navigate to the HomeScreen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                  );
                                } else {
                                  // If the sign-in fails, show an error message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Google Sign-In Failed')),
                                  );
                                }
                              },
                              child: Container(
                                height: screenHeight * 0.02,
                                width: screenWidth * 0.04,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage("./assets/google.png"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.11,
                        ),
                        Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.1,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 248, 248, 248),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              height: screenHeight * 0.02,
                              width: screenWidth * 0.04,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("./assets/apple.png"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Color.fromARGB(255, 248, 248, 248)),
                    ),
                    SizedBox(
                      width: screenWidth * 0.1,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 142, 0, 254),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.1, // 50 Units of height
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
