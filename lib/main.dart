import 'package:chat3/Screens/StartedScreen.dart';
import 'package:chat3/Screens/chat%20list%20screen.dart';
import 'package:flutter/material.dart';
import 'Screens/ChatScreen.dart';
import 'Screens/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/Register.dart';
import 'firebase_options.dart';

void main()
async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase only if not already initialized
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'Login': (context) => Login(),
        'Register': (context) => Register(),
        'chatscreen': (context) => chatscreen(),
        'Started': (context) => Startedscreen(),
        'ChatListScreen': (context) => ChatListScreen(),



      },
      initialRoute: 'Started',
    );
  }
}
