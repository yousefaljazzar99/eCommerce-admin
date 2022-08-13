import 'dart:developer';

import 'package:ecommerce/view/auth/auth_helper.dart';
import 'package:ecommerce/Provider/auth_provider.dart';
import 'package:ecommerce/view/screens/SignUp.dart';
import 'package:ecommerce/view/widget/custom_button_social.dart';
import 'package:ecommerce/view/widget/custum_button.dart';
import 'package:ecommerce/view/widget/custum_textfield.dart';
import 'package:ecommerce/view/screens/forgetPassword.dart';
import 'package:ecommerce/view/screens/profile.dart';
import 'package:ecommerce/models/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class SignInSecreen extends StatefulWidget {
  @override
  State<SignInSecreen> createState() => _SignInSecreen();
}

class _SignInSecreen extends State<SignInSecreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل الدخول'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, x) {
        return Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Form(
                key: provider.loginKey,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/logo copy.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: CustumTextField(
                        textInputType: TextInputType.emailAddress,
                        titel: 'البريد الالكتروني',
                        controller: provider.EmailcontrollerLogin,
                        validtor: provider.validatorEmail,
                        suffix: Icon(
                          Icons.email,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: CustumTextField(
                        hidepassword: true,
                        textInputType: TextInputType.visiblePassword,
                        titel: 'كلمة المرور',
                        controller: provider.PasswordcontrollerLogin,
                        validtor: provider.validatorPassword,
                        suffix: Icon(
                          Icons.lock,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          fixedSize: Size(250, 40)),
                      child: Text('تسجيل الدخول'),
                      onPressed: () async {
                        await provider.signIn();
                        // AuthHelper.authHelper.signInWithEmailAndPassword(
                        //     provider.Emailcontroller.text,
                        //     provider.Passwordcontroller.text);
                        //AppRouter.NavigateWithReplacemtnToWidget(profile());
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          fixedSize: Size(250, 40)),
                      child: Text('مستخدم جديد'),
                      onPressed: () {
                        //provider.signUp();
                        AppRouter.NavigateWithReplacemtnToWidget(SignUp());
                        // AuthHelper.authHelper.signUp(
                        //     Emailcontroller.text, Passwordcontroller.text);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // CustomButtonSocial(
                    //   text: 'Sign In with Google',
                    //   onPress: () {
                    //     Provider.of<AuthProvider>(context).signInhGoogle();
                    //     //controller.googleSignInMethod();
                    //   },
                    //   imageName: 'assets/images/Google.png',
                    // ),
                    TextButton(
                      onPressed: () {
                        AppRouter.NavigateToWidget(ForgetPassword());
                      },
                      child: Text(
                        'نسيت كلمة المرور؟',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
