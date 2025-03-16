import 'package:flutter/material.dart';
import 'package:new_flutter_app/core/utiles/app_colors.dart';

class btnWidget extends StatelessWidget {

  const btnWidget({
    super.key,
    this.width=250,
    this.height=45,
    this.bgColor,
    this.txtColor,
    required this.onPress,
    required this.title,

  });

  final String title;
  final double width;
  final double height;
  final Color? bgColor;
  final Color? txtColor;
  final Function() onPress;



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPress,
        child:Text(title ,
         style:    TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 11),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),

        ),
      ),
    );
  }
}