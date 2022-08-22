import 'package:ecommerce/Provider/auth_provider.dart';
import 'package:ecommerce/view/widget/custum_textfield.dart';
import 'package:ecommerce/models/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class ForgetPassword extends StatelessWidget {
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Passwordcontroller = TextEditingController();

  String? validatorEmail(String v) {
    if (!isEmail(v)) {
      return 'invalid email syntax';
    }
  }

  @override
  Widget build(Object context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('استعادة كلمة المرور'),
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, x) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  child: Image.asset('assets/images/logo copy.png'),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: CustumTextField(
                    textInputType: TextInputType.emailAddress,
                    titel: 'البريد الالكتروني',
                    controller: provider.LoginemailController,
                    validtor: provider.validatorEmail,
                    suffix: Icon(Icons.email),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 48,
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        fixedSize: Size(250, 40)),
                    child: Text('استعادة كلمة المرور'),
                    onPressed: () {
                      provider.ForgetPassword();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
