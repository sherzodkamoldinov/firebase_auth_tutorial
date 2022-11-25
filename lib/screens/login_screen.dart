import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_tutorial/screens/login_email_password_screen.dart';
import 'package:firebase_auth_tutorial/screens/phone_screen.dart';
import 'package:firebase_auth_tutorial/screens/signup_email_password_screen.dart';
import 'package:firebase_auth_tutorial/services/firebase_auth_methods.dart';
import 'package:firebase_auth_tutorial/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, EmailPasswordSignup.routeName);
              },
              text: 'Email/Password Sign Up',
            ),
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, EmailPasswordLogin.routeName);
              },
              text: 'Email/Password Login',
            ),
            CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, PhoneScreen.routeName);
                },
                text: 'Phone Sign In'),
            CustomButton(
              onTap: () {
                FirebaseAuthMethods(FirebaseAuth.instance)
                    .signInWithGoogle(context);
              },
              text: 'Google Sign In',
            ),
            CustomButton(
              onTap: () {},
              text: 'Facebook Sign In',
            ),
            CustomButton(
              onTap: () {},
              text: 'Anonymous Sign In',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        debugPrint(FirebaseAuth.instance.currentUser.toString());
        // // log out
        // await Future.wait([
        //   FirebaseAuth.instance.signOut(),
        //   GoogleSignIn().signOut(),
        // ]);
      }),
    );
  }
}
