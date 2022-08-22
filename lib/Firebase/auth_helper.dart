import 'dart:developer';

import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/view/screens/CategoriesScreen.dart';
import 'package:ecommerce/view/screens/sign_in_screen.dart';
import 'package:ecommerce/view/widget/custum_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      log('done');
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustumDialog.showDialogFunction('البريد المدخل غير مسجل في النظام.');
      } else if (e.code == 'wrong-password') {
        CustumDialog.showDialogFunction('كلمة المرور او البريد خاطئة');
      }
    }
  }

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      final credential =
          await firebaseAuthInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustumDialog.showDialogFunction('كلمة المرور المدخلة ضعيفة');
      } else if (e.code == 'email-already-in-use') {
        CustumDialog.showDialogFunction('هذا البريد مسجل مسبقاً');
      }
    } catch (e) {
      print(e);
    }
  }

  VerifyEmail(String email) async {
    User? user = firebaseAuthInstance.currentUser;
    user?.sendEmailVerification();
    CustumDialog.showDialogFunction(
        'تبقت خطوة واحدة , راجع البريد الالكتروني وقم بتفعيل الحساب..');
  }

  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  checkUser() async {
    User? user = firebaseAuthInstance.currentUser;
    if (user == null) {
      AppRouter.NavigateWithReplacemtnToWidget(SignInSecreen());
    } else {
      AppRouter.NavigateWithReplacemtnToWidget(CategoriesScreen());
    }
  }

  signOut() async {
    await firebaseAuthInstance.signOut();
    AppRouter.NavigateWithReplacemtnToWidget(SignInSecreen());
  }

  sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      CustumDialog.showDialogFunction(
          ' الرجاء مرااجعة البريد  الالكتروني لتغيير كلمة المرور الخاصة بك');
    } on Exception catch (e) {
      // TODO
    }
  }

  delete() async {
    await delete();
  }
}
