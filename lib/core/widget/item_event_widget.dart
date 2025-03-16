import 'package:flutter/material.dart';
import 'package:new_flutter_app/core/utiles/app_colors.dart';

class item_event_widget extends StatelessWidget {
  const item_event_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     margin:EdgeInsets.only(bottom: 20),
      padding:EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      height: 220,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/img/birthday.png"),
        fit: BoxFit.fill),
        border: Border.all(
          color: AppColors.primaryLight,
          width: 2
        ),
          borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            "اعرض هنا اسم المناسبة ",
            style: TextStyle(
              color: AppColors.primaryLight,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.whiteColor,
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "اعرض هنا تاريخ يوم المناسبة ",
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "اعرض هنا الشهر بالكلمات",
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
