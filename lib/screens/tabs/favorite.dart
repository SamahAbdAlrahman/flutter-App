import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:new_flutter_app/core/utiles/app_colors.dart';

import '../../core/data/event_model.dart';
import '../../core/utiles/firebase_utils.dart';
import '../../core/widget/item_event_widget.dart';

class favorite extends StatefulWidget{
  @override
  State<favorite> createState() => _favoriteState();
}



class _favoriteState extends State<favorite> {
  @override
  void initState() {
    super.initState();
    getFavoriteEvent();
  }


  List eventList=[];


  void getFavoriteEvent() async{
    QuerySnapshot<EventModel> events=await firebaseUtiles
        .getEventCollection().
    where('isFavorite', isEqualTo: true).get();


    eventList=events.docs.map((doc){


      return doc.data();
    }).toList();
    setState(() {
      
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.favorite),
      ),
      body: eventList.isEmpty?Center(
        child: Text(  AppLocalizations.of(context)!.noFavoriteEvents,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.redColor),
        ),
      ):Column(
        children: [
      Expanded(
        child: ListView.builder(
        itemCount: eventList.length,
          itemBuilder: (context, index) {
            var event = eventList[index];
            return item_event_widget(
                event: event,
              onFavoriteToggle: () {
              setState(() {
                if (!event.isFavorite) {
                  eventList.removeAt(index);
                }
              });
            },


            );
          },
        ),
      ),
        ],
      )
    );
  }
}