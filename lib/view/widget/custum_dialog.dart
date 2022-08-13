import 'package:ecommerce/models/router.dart';
import 'package:flutter/material.dart';

class CustumDialog {
  static showDialogFunction(String content) {
    showDialog(
        context: AppRouter.navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    AppRouter.popRoute();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }
}
