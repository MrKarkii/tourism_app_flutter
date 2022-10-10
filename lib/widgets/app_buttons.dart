import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tourism_app/widgets/app_text.dart';
import '../misc/colors.dart';

class AppButton extends StatelessWidget {

  final Color color;
  final Color backgroundColor;
  double size;
  final Color borderColor;
  String? text;
  IconData? icon;
  bool? isIcon;

   AppButton({Key? key,
     this.isIcon=false,
     required this.size,
     required this.color,
     required this.backgroundColor,
     required this.borderColor,
     this.text='hi',
     this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.0
        ),
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      child: isIcon==false?Center(child: AppText(text: text!,color: color,)):Center(child: Icon(icon, color: color,)),
    );
  }
}
