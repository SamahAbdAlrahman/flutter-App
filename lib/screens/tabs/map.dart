import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:new_flutter_app/core/utiles/app_colors.dart';

class map extends StatefulWidget{
  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Text(AppLocalizations.of(context)!.lg),
      ),
      body:Container(
        child: Text("map"),
      ),);
  }
}