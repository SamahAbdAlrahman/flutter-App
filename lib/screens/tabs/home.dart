import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter_app/core/utiles/app_colors.dart';
import 'package:new_flutter_app/core/utiles/firebase_utils.dart';
import 'package:new_flutter_app/core/widget/item_event_widget.dart';
import 'package:new_flutter_app/core/widget/tab_event_widget.dart';
import 'package:provider/provider.dart';

import '../../core/data/event_model.dart';
import '../../core/provider/AppLanguageProvider.dart';

class hometap extends StatefulWidget{
  @override
  State<hometap> createState() => _homeState();
}

class _homeState extends State<hometap> {

  int selectedIndex=0;
  List eventList=[];
  List filteredEventList=[];

  void filterEvents() {
    List <String> eventTitleList = [
      "All",
      "Sport",
      "Birthday",
      "Gaming",
      "Meeting",
      "Workshop",
    ];
    if (selectedIndex == 0) {
      filteredEventList = List.from(eventList);
    } else {
      String selectedEventName = eventTitleList[selectedIndex];
      filteredEventList = eventList.where((event) => event.eventName == selectedEventName).toList();
    }
    setState(() {

    });
  }

  void getEvent() async{
QuerySnapshot<EventModel> events=await firebaseUtiles.getEventCollection().get();
eventList=events.docs.map((doc){


  return doc.data();
}).toList();
filterEvents();
    setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    getEvent();
  }
  @override
  Widget build(BuildContext context) {

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
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: Colors.white,
                    indicatorColor: Colors.transparent,

                    onTap: (index){
          setState(() {
            selectedIndex=index;
            filterEvents();
          });
                    },
                    tabs: [
                      ...eventTitleList.map((eventName) {
                        return TabEvent(

                          backgroundColor: AppColors.transparentColor,
                          textSelectedStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                          textUnSelectedStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          borderColor: AppColors.whiteColor,
                          name: eventName,
                          isSelected: selectedIndex == eventTitleList.indexOf(eventName),
                        );

                      }).toList(),
                    ],

                  ),
                ),


              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              itemCount: filteredEventList.length,
              itemBuilder: (context, index) {
                var event = filteredEventList[index];

                return Dismissible(
                  key: UniqueKey(),
                  secondaryBackground: Container(
                    decoration: BoxDecoration(
                      color: AppColors.redColor,
                      border: Border.all(color: AppColors.primaryLight, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 25,bottom: 33),
                    padding: EdgeInsets.symmetric(horizontal: 20),

                    child: Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      color: AppColors.yellowColor,
                      border: Border.all(color: AppColors.primaryLight, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 25,bottom: 33),
                    padding: EdgeInsets.symmetric(horizontal: 20),

                    child: Icon(Icons.edit, color: Colors.white, size: 30),
                  ),
                  onDismissed: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      //  عند السحب من اليسار إلى اليمين
                    // تعديل
                      showEditDialog(context, event);
                    } else if (direction == DismissDirection.endToStart) {
                      //   حذف
                      // يمين لليسار
                      try {
                        await firebaseUtiles.getEventCollection()
                            .doc(event.id)
                            .delete();

                        setState(() {
                          filteredEventList.removeAt(index);
                          eventList.removeWhere((e) => e.id == event.id);
                        });
                      } catch (e) {
                        print("Error deleting event: $e");
                      }
                    }
                  },
                  child: item_event_widget(
                    event: EventModel(
                      title: event.title,
                      description: event.description,
                      dateTime: event.dateTime,
                      time: event.time,
                      eventName: event.eventName,
                        id:event.id,
                    ),

                  ),
                );

              },
            ),
          ),

        ],
      ),
    );
  }
  void showEditDialog(BuildContext context, EventModel event) {
    final titleController = TextEditingController(text: event.title);
    final descriptionController = TextEditingController(text: event.description);
    final dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(event.dateTime));
    final timeController = TextEditingController(text: event.time);
    final eventNameController = TextEditingController(text: event.eventName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Event"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date (yyyy-mm-dd)'),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Time'),
                keyboardType: TextInputType.datetime,
              ),
              DropdownButtonFormField<String>(
                value: eventNameController.text,
                onChanged: (String? newValue) {
                  setState(() {
                    eventNameController.text = newValue!;
                  });
                },
                items: ['Sport', 'Birthday', 'Gaming', 'Meeting', 'Workshop']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Event Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async  {
                event.title = titleController.text;
                event.description = descriptionController.text;
                event.dateTime = DateFormat('yyyy-MM-dd').parse(dateController.text);
                event.time = timeController.text;
                event.eventName = eventNameController.text;

                try {
                  await firebaseUtiles.getEventCollection().doc(event.id).update(event.toFireStore());

                  setState(() {
                    filteredEventList[filteredEventList.indexOf(event)] = event;
                    eventList[eventList.indexOf(event)] = event;
                  });

                  Navigator.of(context).pop();
                } catch (e) {
                  print("Error updating event: $e");
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }


}
