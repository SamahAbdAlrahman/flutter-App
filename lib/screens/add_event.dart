import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter_app/core/utiles/app_colors.dart';
import 'package:new_flutter_app/screens/tabs/home.dart';
import 'package:provider/provider.dart';

import '../core/data/event_model.dart';
import '../core/data/event_provider.dart';
import '../core/provider/AppLanguageProvider.dart';
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
  List<EventModel> eventsList = [];

  var _formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var dateController = TextEditingController(text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  var imageController = TextEditingController(); // صورة الحدث
  var start_dateControler = TextEditingController();
  var end_dateControler = TextEditingController();
  int selectedColor = 0;

  void addEventToList(EventModel event) {
    print("Event added: ${event.title}");
  }


  @override
  Widget build(BuildContext context) {

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.redColor, width: 1.5), // الإطار عند الخطأ
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.redColor, width: 2.5), // الإطار عند التركيز مع الخطأ
          ),
          errorStyle: TextStyle(
            color: AppColors.redColor,
            fontSize: 14,
          ),
        ),
      ),
      child: Scaffold(
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
            child: Form(
              key: _formKey,
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
                  Text(AppLocalizations.of(context)!.eventTitle, style: TextStyle(
                      color: Theme.of(context).appBarTheme.backgroundColor, fontSize: 17, fontWeight: FontWeight.w500)),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Title is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.enterEventTitle,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!.eventNote, style: TextStyle(color: Theme.of(context).appBarTheme.backgroundColor, fontSize: 17, fontWeight: FontWeight.w500)),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: noteController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Note is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.enterEventNote,
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!.eventDate, style: TextStyle(color: Theme.of(context).appBarTheme.backgroundColor, fontSize: 17, fontWeight: FontWeight.w500)),
                  SizedBox(height: 5),
                  TextFormField(
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      );
                      if (selectedDate != null) {
                        dateController.text = DateFormat("dd/MM/yyyy").format(selectedDate);
                      }
                    },
                    readOnly: true,
                    controller: dateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Date is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today, color: AppColors.redColor),
                    ),
                  ),
                  SizedBox(height: 10),
                  btnWidget(
                    title:AppLocalizations.of(context)!.addEvent,
                    width: 150,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        EventModel newEvent = EventModel(
                          id: DateTime.now().toString() + titleController.text,
                          title: titleController.text,
                          note: noteController.text,
                          date: dateController.text,
                          startTime: start_dateControler.text,
                          endTime: end_dateControler.text,
                          Color: selectedColor,
                          isCompleted: false,
                        );

                        Provider.of<EventProvider>(context, listen: false).addEvent(newEvent);

                        print("Event added: ${newEvent.title}");
                        pushReplace(context, hometap());
                      }
                    },
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
