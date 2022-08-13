import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/view/auth/auth_helper.dart';
import 'package:ecommerce/view/screens/country.dart';
import 'package:ecommerce/view/screens/forgetPassword.dart';
import 'package:ecommerce/view/screens/profile.dart';
import 'package:ecommerce/view/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {
  String? validatorEmail(String v) {
    if (!isEmail(v)) {
      return 'خطأ في البريد الالكتروني';
    }
  }

  String? validatorName(String v) {
    if (v.length < 3) {
      return 'يجب ان يحتوي الاسم على 3 احرف على الاقل';
    }
  }

  String? validatorPhone(String v) {
    if (v.length < 9 || v.length > 10) {
      return 'يجب ان يتكون الرقم المدخل من 9 او 10 خانات';
    }
  }

  String? validatorPassword(String v) {
    if (v.length < 6) {
      return 'يجب ان تكون كلمة المرور 6 احرف على الاقل';
    }
  }

  String? checkBoxValidator(bool? x) {
    if (!(x!)) {
      return 'you have to accept our conditions first';
    }
  }

  Country? selectedCountry;
  String? selectedCity;
  GlobalKey<FormState> loginKey = GlobalKey();
  GlobalKey<FormState> SignUpKey = GlobalKey();
  TextEditingController EmailcontrollerLogin = TextEditingController();
  TextEditingController PasswordcontrollerLogin = TextEditingController();

  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Idcontroller = TextEditingController();

  TextEditingController Phonecontroller = TextEditingController();
  TextEditingController UserNamecontroller = TextEditingController();
  TextEditingController Passwordcontroller = TextEditingController();

  signIn() async {
    if (loginKey.currentState!.validate()) {
      UserCredential? credential = await AuthHelper.authHelper
          .signInWithEmailAndPassword(
              EmailcontrollerLogin.text, PasswordcontrollerLogin.text);
      if (credential != null) {
        AppRouter.NavigateWithReplacemtnToWidget(profile());
      }
    }
  }

  signUp() async {
    if (SignUpKey.currentState!.validate()) {
      UserCredential? credential = await AuthHelper.authHelper
          .signUp(Emailcontroller.text, Passwordcontroller.text);
      if (credential != null) {
        AppRouter.NavigateWithReplacemtnToWidget(profile());
      }
    }
  }

  checkUser() {
    AuthHelper.authHelper.checkUser();
  }

  signOut() {
    AuthHelper.authHelper.signOut();
  }

  ForgetPassword() async {
    await AuthHelper.authHelper
        .sendPasswordResetEmail(EmailcontrollerLogin.text);
  }
}
