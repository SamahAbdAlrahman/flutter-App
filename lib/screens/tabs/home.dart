import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter_app/core/utiles/app_colors.dart';
import 'package:new_flutter_app/core/widget/item_event_widget.dart';
import 'package:new_flutter_app/core/widget/tab_event_widget.dart';
import 'package:provider/provider.dart';

import '../../core/data/event_model.dart';
import '../../core/data/event_provider.dart';
import '../../core/provider/AppLanguageProvider.dart';

class hometap extends StatefulWidget{
  @override
  State<hometap> createState() => _homeState();
}

class _homeState extends State<hometap> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    var events = Provider.of<EventProvider>(context).events;

    var languageProvider = Provider.of<AppLanguageProvider>(context);
    List<String> eventTitleList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.workshope,
    ];


    return Scaffold(
      appBar: AppBar(
          title:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
            Text("welcome"),
            SizedBox(height: 2,),
            Text("samah saeed",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
                  ],
                ),
                Column(
                  children: [
              Icon(Icons.sunny),
                    SizedBox(height: 3,),

                    if (languageProvider.appLanguage == "ar")
                      Container(
                        child:Text("AR",style: TextStyle(color: AppColors.whiteColor),),

                      )
                    else
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(30)

                          ),
                          child:Text("EN",style: TextStyle(fontSize:14,color: AppColors.primaryLight),),

                        )


                  ],
                ),

              ],
            ),
          )
      ),
      body:
      Column(
        children: [
          Container(
            padding:  const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
            height: 133,
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              )
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_outlined , size: 24,color: AppColors.whiteColor,),
                    Text("Nablus , pals" ,
                    style:TextStyle(
                        color:  AppColors.whiteColor,
                        fontSize: 18
                      ),),

                  ],
                ),
                DefaultTabController(
                  length: eventTitleList.length,
                  child: TabBar(

                    labelPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    isScrollable: true,//قربو عن بعض
                    tabAlignment: TabAlignment.start, //صارو عاليسار
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: Colors.white,
                    indicatorColor: Colors.transparent,

                    onTap: (index){
          setState(() {
            selectedIndex=index;

          });
                    },
                    tabs: [
                      ...eventTitleList.map((eventName) {
                        return tabEvent(name: eventName,
                            isSelected:
                            selectedIndex==eventTitleList.indexOf(eventName));
                      }).toList(),
                    ],

                  ),
                ),


              ],
            ),
          ),

          Expanded(

            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 18),
              itemCount: events.length,
              itemBuilder: (context, index) {
                EventModel event = events[index];
                return Column(
                  children: [
                    Text(
                      " ${event.title}",
                      style: TextStyle(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      height: 220,
                      width:350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/birthday.png"),
                            fit: BoxFit.fill
                        ),
                        border: Border.all(
                            color: AppColors.primaryLight,
                            width: 2
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.whiteColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.date,
                                  style: TextStyle(
                                    color: AppColors.primaryLight,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                );
              },


            ),
          ),
        ],
      ),
    );
  }
}
