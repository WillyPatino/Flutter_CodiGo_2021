import 'package:flutter/material.dart';

const labelTextStyle=TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

class IconContent extends StatelessWidget {

  final String text;
  final IconData icon;

  IconContent({@required this.text, @required this.icon });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          this.icon,
          size: 70.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          this.text,
          style: labelTextStyle,
        ),
      ],
    );
  }
}