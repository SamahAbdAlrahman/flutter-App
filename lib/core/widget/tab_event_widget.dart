import 'package:flutter/material.dart';
import 'package:new_flutter_app/core/utiles/app_colors.dart';

class tabEvent extends StatelessWidget {
  String name;
  bool isSelected;
  tabEvent({
    super.key,
    required this.name,
    required this.isSelected

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      decoration: BoxDecoration(
        color: isSelected?AppColors.whiteColor:AppColors.transparentColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.whiteColor,
          width: 2

        )
      ),
      child: Text(name ,
        style: TextStyle(color:
        isSelected?Theme.of(context).appBarTheme.backgroundColor:AppColors.whiteColor,),
      ),
    );
  }
}