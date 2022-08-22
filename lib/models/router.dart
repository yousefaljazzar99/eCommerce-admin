import 'package:ecommerce/view/screens/CategoriesScreen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  static Future<String?> NavigateToWidget(Widget widget) async {
    String? x = await Navigator.of(navKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
    return x;
  }

  static popRouter() {
    Navigator.of(navKey.currentContext!).pop();
  }

  static NavigateWithReplacemtnToWidget(Widget widget) {
    Navigator.of(navKey.currentContext!)
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}

const GreenColors = Colors.green;
const kPrimaryLightColor = Color(0xFFF1E6FF);
const double defaultPadding = 16.0;
