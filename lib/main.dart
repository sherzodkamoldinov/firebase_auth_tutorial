import 'package:firebase_auth_tutorial/screens/login_email_password_screen.dart';
import 'package:firebase_auth_tutorial/screens/login_screen.dart';
import 'package:firebase_auth_tutorial/screens/phone_screen.dart';
import 'package:firebase_auth_tutorial/screens/signup_email_password_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // init flutter widgets
  WidgetsFlutterBinding.ensureInitialized();
  // init firebase
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      routes: {
        EmailPasswordSignup.routeName: (context) => const EmailPasswordSignup(),
        EmailPasswordLogin.routeName: (context) => const EmailPasswordLogin(),
        PhoneScreen.routeName: (context) => const PhoneScreen(),
      },
    );
  }
}
