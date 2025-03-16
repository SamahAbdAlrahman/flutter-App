import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:new_flutter_app/core/utiles/app_colors.dart';
import 'package:new_flutter_app/screens/tabs/favorite.dart';
import 'package:new_flutter_app/screens/tabs/home.dart';
import 'package:new_flutter_app/screens/tabs/map.dart';
import 'package:new_flutter_app/screens/tabs/profile.dart';
import 'package:provider/provider.dart';

import '../core/provider/AppLanguageProvider.dart';
import '../core/provider/AppThemeProvider.dart';
import 'add_event.dart';

class maintab extends StatefulWidget{
  @override
  State<maintab> createState() => _maintabState();
}

class _maintabState extends State<maintab> {
  int selectedIndex=0;
  final List <Widget> tabs=[
    hometap(),
    map(),
    favorite(),
    profile(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEventPage()),
          );
        },

        child: Icon(Icons.add),
        backgroundColor:Theme.of(context).floatingActionButtonTheme.backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 7,
              color: Theme.of(context).scaffoldBackgroundColor
          ),
          borderRadius: BorderRadius.circular(100)
        ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomNavigationBar(
          currentIndex:selectedIndex,
        onTap: (index){
setState(() {
  selectedIndex=index;

});            },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: AppLocalizations.of(context)!.map,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: AppLocalizations.of(context)!.favorite,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,

      ),

  body:tabs[selectedIndex]
);
  }
}

