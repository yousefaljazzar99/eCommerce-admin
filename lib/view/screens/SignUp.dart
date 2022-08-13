import 'dart:developer';

import 'package:ecommerce/view/auth/auth_helper.dart';
import 'package:ecommerce/Provider/auth_provider.dart';
import 'package:ecommerce/view/auth/AppUser.dart';
import 'package:ecommerce/view/auth/firestore_helper.dart';
import 'package:ecommerce/view/screens/country.dart';
import 'package:ecommerce/view/screens/custom_checkbox.dart';
import 'package:ecommerce/view/screens/sign_in_screen.dart';
import 'package:ecommerce/view/widget/custom_button_social.dart';
import 'package:ecommerce/view/widget/custum_button.dart';
import 'package:ecommerce/view/widget/custum_textfield.dart';
import 'package:ecommerce/view/screens/forgetPassword.dart';
import 'package:ecommerce/view/screens/profile.dart';
import 'package:ecommerce/models/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpSecreen();
}

class _SignUpSecreen extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل مستخدم جديد'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, x) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Form(
                  key: provider.SignUpKey,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        child: Image.asset('assets/images/logo copy.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: CustumTextField(
                          textInputType: TextInputType.emailAddress,
                          titel: 'رقم الهوية',
                          controller: provider.Idcontroller,
                          validtor: provider.validatorPhone,
                          suffix: Icon(Icons.verified),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: CustumTextField(
                          textInputType: TextInputType.emailAddress,
                          titel: 'اسم المستخدم',
                          controller: provider.UserNamecontroller,
                          validtor: provider.validatorName,
                          suffix: Icon(Icons.person),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: CustumTextField(
                          textInputType: TextInputType.emailAddress,
                          titel: 'البريد الالكتروني',
                          controller: provider.Emailcontroller,
                          validtor: provider.validatorEmail,
                          suffix: Icon(Icons.email),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: CustumTextField(
                          textInputType: TextInputType.emailAddress,
                          titel: 'رقم الهاتف',
                          controller: provider.Phonecontroller,
                          validtor: provider.validatorPhone,
                          suffix: Icon(Icons.phone),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: CustumTextField(
                          hidepassword: true,
                          textInputType: TextInputType.visiblePassword,
                          titel: 'كلمة المرور',
                          controller: provider.Passwordcontroller,
                          validtor: provider.validatorPassword,
                          suffix: Icon(Icons.lock),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'حدد الدولة من القائمة',
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButton<Country>(
                            isExpanded: true,
                            underline: SizedBox(),
                            value: provider.selectedCountry,
                            items: countries.map((e) {
                              return DropdownMenuItem<Country>(
                                value: e,
                                child: Text(e.name),
                              );
                            }).toList(),
                            onChanged: (v) {
                              provider.selectedCountry = v;
                              provider.selectedCity = v!.cities.first;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'حدد المدينة من القائمة',
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(
                              15,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(),
                            value: provider.selectedCity,
                            items: provider.selectedCountry?.cities.map((e) {
                              return DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (v) {
                              provider.selectedCity = v;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      CustomCheckbox(
                        validator: provider.checkBoxValidator,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            textStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            fixedSize: Size(250, 40)),
                        child: Text('تسجيل جديد'),
                        onPressed: () {
                          FirestoreHelper.firestoreHelper.addUserToFirestore(
                              id: provider.Idcontroller.text,
                              userName: provider.UserNamecontroller.text,
                              email: provider.Emailcontroller.text,
                              phone: provider.Phonecontroller.text,
                              country: provider.selectedCountry!.name,
                              city: provider.selectedCity ?? 'not define');
                          provider.signUp();

                          // AuthHelper.authHelper.signInWithEmailAndPassword(
                          //     provider.Emailcontroller.text,
                          //     provider.Passwordcontroller.text);
                          // AppRouter.NavigateWithReplacemtnToWidget(profile());
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextButton(
                          onPressed: () {
                            AppRouter.NavigateWithReplacemtnToWidget(
                                SignInSecreen());
                          },
                          child: Text(
                            'لديك حساب بالفعل؟',
                            style: TextStyle(color: Colors.green),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
