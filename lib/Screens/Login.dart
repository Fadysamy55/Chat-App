
import 'package:chat3/Screens/Register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../Constans/Const.dart';
import '../Widgets/Customtext.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ChatScreen.dart';
import 'chat list screen.dart';
class Login extends StatefulWidget {
  Login({super.key});

  Register get id => Register();

  @override
  State<Login> createState() => _RegisterState();
}

class _RegisterState extends State<Login> {
  String id = 'Login';
  String? email;

  String? password;

  bool isLoading = false ;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(inAsyncCall: isLoading, child:
    Scaffold(
        backgroundColor: kPrimaryColor,
        body:Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formkey ,
              child: ListView(
                shrinkWrap: true,
                children: [
                  // Column widget will stack the image and text vertically
                  Column(
                    mainAxisSize: MainAxisSize.min, // Ensures the Column takes only as much space as needed
                    children: [
                      Image.network(
                        'https://raw.githubusercontent.com/Fadysamy55/ppro/refs/heads/main/scholar.png',
                      ),
                      // Add space between the image and the text if needed
                      SizedBox(height: 10),
                      // The "Scholar Chat" text, positioned directly under the image
                      Text(
                        "Scholar Chat",
                        style: GoogleFonts.pacifico(
                          fontSize: 32.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // Space between the image and other UI components
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),

                  CustomFormTextField(
                    obscureText: false,
                    onChanged:(data){
                      email= data;
                    },
                    hintText: 'Email',
                  ),
                  SizedBox(height: 8),


                  CustomFormTextField(
                    obscureText: true,

                    onChanged:(data){

                      password= data;
                    },

                    hintText: 'Password',
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await Login();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => chatscreen(), ),
                          );
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'user-not-found') {
                            showsnackbar(context, 'user not found');
                          } else if (ex.code == 'wrong-password') {
                            showsnackbar(context, 'wrong password');
                          }
                        } catch (ex) {
                          print(ex);
                          showsnackbar(context, 'there was an error');
                        }

                        isLoading = false;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => ChatListScreen()),
                       );
                      } else {}
                    },
                    text: 'LOGIN',
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                      'don\'t have an account..?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap:()
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Register()),
                            );

                          },
                          child:
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xffc7EDE6),
                            ),
                          ),
                        ), // Adding some spacing between the texts

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )

    ),
    );


  }


  Future<void> Login() async {
    UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
    );
  }
}
