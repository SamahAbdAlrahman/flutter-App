import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter_app/core/data/event_model.dart';
import 'package:new_flutter_app/core/utiles/app_colors.dart';
import '../core/utiles/firebase_utils.dart';
import '../core/widget/btnWidget.dart';
import '../core/widget/tab_event_widget.dart';
import '../functions/navigoter.dart';
import 'main_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  int selectedIndex = 0;



  var _formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
DateTime? selectedDate;
TimeOfDay? selectedTime;
  int selectedColor = 0;

String selectedeventName='';


  @override
  Widget build(BuildContext context) {
    // CollectionReference events = FirebaseFirestore.instance.collection('events');
    Future<void> addEvent() async{
var event = EventModel(
    title: titleController.text,
    description: descriptionController.text,
    dateTime: selectedDate!,
    time: selectedTime!.format(context),
    eventName:selectedeventName,
    id: UniqueKey().toString()
);

try{
  firebaseUtiles.addEventToFirebase(event);
print("added event done");

}
    catch(e){
  print(e);
    }}
    List<String> eventTitleList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.workshope,
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            pushReplace(context, maintab());
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(AppLocalizations.of(context)!.addEvent, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                height: 220,
                width: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/birthday.png"),
                      fit: BoxFit.fill),
                  border: Border.all(color: AppColors.primaryLight, width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              DefaultTabController(
                length: eventTitleList.length,
                child: TabBar(

                  labelPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.transparent,

                  onTap: (index){
                    setState(() {
                      selectedIndex=index;
                      selectedeventName=eventTitleList[index];

                    });
                  },
                  tabs: [
                    ...eventTitleList.map((eventName) {
                      return TabEvent(
                        backgroundColor: AppColors.primaryLight,
                        textSelectedStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        textUnSelectedStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryLight,
                        ),
                        borderColor: AppColors.primaryLight,
                        name: eventName,
                        isSelected: selectedIndex == eventTitleList.indexOf(eventName),
                      );
                    }).toList(),
                  ],

                ),
              ),


              //form to add event
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // title
              Text(AppLocalizations.of(context)!.eventTitle, style: _titleStyle(context)),
              const SizedBox(height: 5),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: titleController,
                validator: (value) => (value == null || value.isEmpty) ? "Title is required" : null,
                decoration: _inputDecoration(AppLocalizations.of(context)!.enterEventTitle),
              ),
              const SizedBox(height: 10),

              // description
              Text(AppLocalizations.of(context)!.eventNote, style: _titleStyle(context)),
              const SizedBox(height: 5),
              TextFormField(
                style: TextStyle(color: Colors.black),

                controller: descriptionController,
                validator: (value) => (value == null || value.isEmpty) ? "Description is required" : null,
                decoration: _inputDecoration(AppLocalizations.of(context)!.enterEventNote),
                maxLines: 4,
              ),
              const SizedBox(height: 10),


              //date
              Text(AppLocalizations.of(context)!.eventDate, style: _titleStyle(context)),
              const SizedBox(height: 5),
              TextFormField(
                style: TextStyle(color: Colors.black),

                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  print(pickedDate);

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                      dateController.text = DateFormat("dd/MM/yyyy").format(pickedDate);
                    });
                  }
                  print(selectedDate);
                },
                readOnly: true,
                controller: dateController,
                validator: (value) => (value == null || value.isEmpty) ? "Date is required" : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today, color: AppColors.redColor),
                ),
              ),
              const SizedBox(height: 10),


              // time
              Text(AppLocalizations.of(context)!.eventTime, style: _titleStyle(context)),
              const SizedBox(height: 5),
              TextFormField(
                style: TextStyle(color: Colors.black),


                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  print(pickedTime);

                  if (pickedTime != null) {
                    setState(() {
                      selectedTime = pickedTime;
                      timeController.text = pickedTime.format(context);
                    });
                  }
                  print(selectedTime);

                },
                readOnly: true,
                controller: timeController,
                validator: (value) => (value == null || value.isEmpty) ? "Time is required" : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time_outlined, color: AppColors.redColor),
                ),
              ),
              const SizedBox(height: 10),

              // add btn
              btnWidget(
                title: AppLocalizations.of(context)!.addEvent,
                width: 150,
                onPress: () {

                  if (_formKey.currentState!.validate()) {

                    addEvent();

                  }
                },
              ),
            ],
          ),
        ),
      //
        ],
      ),

    ),
    ),
    );
  }

  TextStyle _titleStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).appBarTheme.backgroundColor,
      fontSize: 17,
      fontWeight: FontWeight.w500,
    );
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: labelText,
    );
  }
}