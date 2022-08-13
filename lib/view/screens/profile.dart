import 'package:ecommerce/Provider/firestore_provider.dart';
import 'package:ecommerce/view/auth/auth_helper.dart';
import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/Provider/auth_provider.dart';
import 'package:ecommerce/view/auth/firestore_helper.dart';
import 'package:ecommerce/view/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('الصفحة الرئيسية'),
        actions: [
          Consumer<AuthProvider>(builder: (context, Provider, x) {
            return IconButton(
                onPressed: () {
                  Provider.signOut();
                  //  AuthHelper.authHelper.signOut();
                  // AppRouter.NavigateWithReplacemtnToWidget(SignInSecreen());
                },
                icon: Icon(Icons.logout));
          })
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('مرحبا بك في المتجر الاكتروني'),
          onPressed: () {
            Provider.of<FireStoreProvider>(context, listen: false)
                .insertNewCategory();
          },
        ),
      ),
    );
  }
}
