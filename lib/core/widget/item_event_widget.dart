import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter_app/core/data/event_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utiles/app_colors.dart';
import '../utiles/firebase_utils.dart';

class item_event_widget extends StatefulWidget {
final EventModel event;
final VoidCallback? onFavoriteToggle;

  item_event_widget({
    required this.event,
    this.onFavoriteToggle,

  });

  @override
  State<item_event_widget> createState() => _item_event_widgetState();
}

class _item_event_widgetState extends State<item_event_widget> {

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      height: 220,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/img/birthday.png"), fit: BoxFit.fill),
        border: Border.all(color: AppColors.primaryLight, width: 2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  DateFormat('MMM').format(widget.event.dateTime),
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.event.dateTime.month.toString(),
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.event.title,
                  // event.title,
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    print('old : ${widget.event.isFavorite}');


                    try {
                      bool newFavoriteStatus = !widget.event.isFavorite;

                      await firebaseUtiles.getEventCollection().doc(widget.event.id).update({
                        'isFavorite': newFavoriteStatus,
                      });

                      setState(() {
                        widget.event.isFavorite = newFavoriteStatus;
                      });



                      widget.onFavoriteToggle?.call();

                      print('new : ${widget.event.isFavorite}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:AppColors.yellowColor,
                          content: Text(
                            widget.event.isFavorite
                                ? AppLocalizations.of(context)!.added_to_favorites
                                : AppLocalizations.of(context)!.removed_from_favorites,
                          ),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(bottom: 250,left: 40,right: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      );

                      print('new : ${widget.event.isFavorite}');

                    } catch (e) {
                      print("Error updating favorite status: $e");
                    }
                  },

                  child: Icon(
                   Icons.favorite_border,
                    color: AppColors.redColor,
                  ),
                ),              ],
            ),
          ),
        ],
      ),
    );
  }
}
