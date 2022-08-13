import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/view/auth/auth_helper.dart';
import 'package:ecommerce/Provider/auth_provider.dart';
import 'package:ecommerce/view/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatefulWidget {
  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  void initState() {
    super.initState();
    navigationFun(context);
  }

  navigationFun(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    Provider.of<AuthProvider>(context, listen: false).checkUser();
  }
  // initFun() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   Provider.of<AuthProvider>(context, listen: false).checkUser();
  //   // Provider.of<AuthProvider>(context, listen: false).checkUser();
  //   // AppRouter.NavigateWithReplacemtnToWidget(SignInSecreen());
  //   // SpHelper.spHelper.getUser();
  // }

  @override
  Widget build(BuildContext context) {
    //  initFun();
    return Scaffold(
        body: Center(
      child: Image.asset(
        'assets/images/logo copy.png',
        width: 200,
        height: 200,
      ),
    ));
  }
}
