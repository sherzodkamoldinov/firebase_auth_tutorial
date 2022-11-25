import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_tutorial/utils/show_otp_dialog.dart';
import 'package:firebase_auth_tutorial/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            showSnackBar(context, 'THIS IS NEW USER FROM GOOGLE');
          }
        }
      }
    } on FirebaseAuthException catch (e) {}
  }

  // EMAIL SIGN UP (REGISTER)
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // CREATE USER WITH EMAIL
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // LOGIN USER WITH EMAIL (REGISTER)
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // if this email was not verified
      if (!_auth.currentUser!.emailVerified) {
        // again send email verification
        await sendEmailVerification(context);
        // after verification here you can something exm navigate
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // PHONE SIGN IN
  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        showSnackBar(context, e.message!);
      },
      codeSent: ((String verificationId, int? forceResendingToken) {
        showOTPDialog(
          context: context,
          codeController: codeController,
          onPressed: () async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: codeController.text.trim(),
            );
            await _auth.signInWithCredential(credential);
            Navigator.of(context).pop();
          },
        );
      }),
      codeAutoRetrievalTimeout: (String verificationId) {
        // auto resolution timed out
      },
    );
  }
}
