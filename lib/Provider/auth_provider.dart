import 'package:ecommerce/Firebase/auth_helper.dart';
import 'package:ecommerce/Firebase/firestore_helper.dart';
import 'package:ecommerce/models/AppUser.dart';
import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/view/screens/country.dart';
import 'package:ecommerce/view/screens/forgetPassword.dart';
import 'package:ecommerce/view/screens/CategoriesScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {
  nullValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "الحقل مطلوب";
    }
  }

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
  String? countryCode = '970';

  GlobalKey<FormState> loginKey = GlobalKey();
  GlobalKey<FormState> SignUpKey = GlobalKey();
  TextEditingController LoginemailController = TextEditingController();
  TextEditingController LoginpasswordController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  // signIn() async {
  //   if (loginKey.currentState!.validate()) {
  //     UserCredential? credential = await AuthHelper.authHelper
  //         .signInWithEmailAndPassword(
  //             EmailcontrollerLogin.text, PasswordcontrollerLogin.text);
  //     if (credential != null) {
  //       AppRouter.NavigateWithReplacemtnToWidget(profile());
  //     }
  //   }
  // }
  signIn() async {
    if (loginKey.currentState!.validate()) {
      UserCredential? userCredential = await AuthHelper.authHelper
          .signInWithEmailAndPassword(
              LoginemailController.text, LoginemailController.text);
      AppUser appUser = AppUser(
          id: userCredential!.user!.uid, // unique id from firebase auth
          email: LoginemailController.text,
          userName: userNameController.text,
          phone: phoneController.text,
          city: cityController.text,
          country: countryController.text);
      FirestoreHelper.firestoreHelper.getUserFromFirestore(appUser.id!);
      if (userCredential != null) {
        AppRouter.NavigateWithReplacemtnToWidget(CategoriesScreen());
        // emailController.clear();
        // passwordController.clear();
      }
    }
  }

  signUp() async {
    if (SignUpKey.currentState!.validate()) {
      UserCredential? userCredential = await AuthHelper.authHelper
          .signUp(emailController.text, passwordController.text);

      AppUser appUser = AppUser(
          id: userCredential!.user!.uid, // unique id from firebase auth
          email: emailController.text,
          userName: userNameController.text,
          phone: phoneController.text,
          city: cityController.text,
          country: countryController.text);

      FirestoreHelper.firestoreHelper.addUserToFirestore(appUser);

      if (userCredential != null) {
        AppRouter.NavigateWithReplacemtnToWidget(CategoriesScreen());
        // emailController.clear();
        // passwordController.clear();
        // userNameController.clear();
        // phoneController.clear();
        // cityController.clear();
      }
    }
  }

  // signUp() async {
  //   if (SignUpKey.currentState!.validate()) {
  //     UserCredential? credential = await AuthHelper.authHelper
  //         .signUp(Emailcontroller.text, Passwordcontroller.text);
  //     if (credential != null) {
  //       AppRouter.NavigateWithReplacemtnToWidget(profile());
  //     }
  //   }
  // }

  checkUser() {
    AuthHelper.authHelper.checkUser();
  }

  signOut() {
    AuthHelper.authHelper.signOut();
  }

  ForgetPassword() async {
    await AuthHelper.authHelper
        .sendPasswordResetEmail(LoginemailController.text);
  }
}
