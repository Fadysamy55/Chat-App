import 'package:chat3/Screens/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../Constans/Const.dart';
import '../Widgets/Customtext.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Login.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;
  String? name;
  String? address;
  String? phoneNum;
  String? password;
  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        'https://raw.githubusercontent.com/Fadysamy55/ppro/refs/heads/main/scholar.png',
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Scholar Chat",
                        style: GoogleFonts.pacifico(
                          fontSize: 32.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomFormTextField(
                    obscureText: false,
                    onChanged: (data) {
                      name = data;
                    },
                    hintText: 'Name',
                  ),
                  SizedBox(height: 8),
                  CustomFormTextField(
                    obscureText: false,
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  SizedBox(height: 8),
                  CustomFormTextField(
                    obscureText: false,
                    onChanged: (data) {
                      phoneNum = data;
                    },
                    hintText: 'Phone Number',
                  ),
                  SizedBox(height: 8),
                  CustomFormTextField(
                    obscureText: false,
                    onChanged: (data) {
                      address = data;
                    },
                    hintText: 'Address',
                  ),
                  SizedBox(height: 8),
                  CustomFormTextField(
                    obscureText: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          await registerUser();
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'weak-password') {
                            showsnackbar(context, 'Weak password');
                          } else if (ex.code == 'email-already-in-use') {
                            showsnackbar(context, 'Email already exists');
                          }
                        } catch (ex) {
                          showsnackbar(context, 'There was an error');
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    text: 'REGISTER',
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Already have an account?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xffc7EDE6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );

    // Send email verification
    User? user = userCredential.user;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      showsnackbar(context, 'Verification email sent. Please check your inbox.');
    }

    // Store user details in Firestore
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
      'name': name,
      'email': email,
      'phoneNum': phoneNum,
      'address': address,
      'uid': user?.uid,
      'isVerified': false, // Track email verification
    });

    // Navigate to login screen after registration
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }
}
