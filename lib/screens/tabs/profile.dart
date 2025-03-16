import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:new_flutter_app/core/utiles/app_colors.dart';
import 'package:provider/provider.dart';

import '../../core/provider/AppLanguageProvider.dart';
import '../../core/provider/AppThemeProvider.dart';

class profile extends StatefulWidget{
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(

      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:  const EdgeInsets.only(left: 15.0,right: 15,bottom: 35,top: 45),
            height: 200,
            decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                )
            ),
            child: Row(
              children: [
               CircleAvatar(
              radius: 75,
              backgroundImage: AssetImage('assets/img/d.jpg'),
            ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tariq Shreem" ,
                      style:TextStyle(
                          color:  AppColors.whiteColor,
                          fontSize: 22
                      ),),

                    Text("tariqshreem@gmail.com" ,
                      style:TextStyle(
                          color:  AppColors.whiteColor,
                          fontSize: 16
                      ),),

                  ],
                ),

              ],
            ),
          ),


          SizedBox(height: 22,),

    Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (languageProvider.appLanguage == "en")
                  Text(AppLocalizations.of(context)!.eng)
                else      Text(AppLocalizations.of(context)!.ar),
                DropdownButton(

                    hint:Text(AppLocalizations.of(context)!.slg),
                    isExpanded:true,
                    items:[
                      DropdownMenuItem(
                        value:"en",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppLocalizations.of(context)!.eng),
                            if (languageProvider.appLanguage == "en")
                              Icon(Icons.check, color: AppColors.greenColor),
                          ],
                        ),

                      ),
                      DropdownMenuItem(
                        value:"ar",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppLocalizations.of(context)!.ar),
                            if (languageProvider.appLanguage == "ar")
                              Icon(Icons.check, color: AppColors.greenColor),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value){
                      // if (value != null) {
                      languageProvider.changeLanguage(value.toString());
                      // }
                    }
                ),
              ],
            ),
          ),
SizedBox(height: 22,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(themeProvider.appTheme == ThemeMode.dark)
                  Text(AppLocalizations.of(context)!.dark)else Text(AppLocalizations.of(context)!.light),

                  DropdownButton(

                    hint:Text(AppLocalizations.of(context)!.smode),
                    isExpanded:true,
                    items:[
                      DropdownMenuItem(value:ThemeMode.dark,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.dark),
                              if(themeProvider.appTheme == ThemeMode.dark)
                                Icon(Icons.check, color: AppColors.greenColor),

                            ],
                          )
                      ),
                      DropdownMenuItem(  value:ThemeMode.light,

                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.light),
                              if(themeProvider.appTheme == ThemeMode.light)
                                Icon(Icons.check, color: AppColors.greenColor),

                            ],
                          )
                      ),
                    ],
                    onChanged: (value){
                      // if (value != null) {
                      themeProvider.changeTheme(value!);
                      // }
                    }
                ),
              ],
            ),
          )
        ],
      ),

    );

  }
}