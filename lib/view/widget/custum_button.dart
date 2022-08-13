import 'package:flutter/material.dart';

import 'custom_text.dart';

const primaryColor = Color.fromRGBO(0, 197, 105, 1);

class CustomButton extends StatelessWidget {
  final String text;

  final Color color;
  final Color textColor;

  final Function onPress;

  CustomButton({
    required this.onPress,
    this.text = 'Write text ',
    this.color = primaryColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(15),
      onPressed: onPress(),
      color: color,
      child: CustomText(
        alignment: Alignment.center,
        text: text,
        color: textColor,
      ),
    );
  }
}
