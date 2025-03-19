import 'package:flutter/material.dart';
import 'package:new_flutter_app/core/utiles/app_colors.dart';

class TabEvent extends StatelessWidget {
  final String name;
  final bool isSelected;
  final Color borderColor;
  final TextStyle textSelectedStyle;
  final TextStyle textUnSelectedStyle;
  final Color backgroundColor;

  const TabEvent({
    super.key,
    required this.name,
    required this.isSelected,
    required this.borderColor,
    required this.textSelectedStyle,
    required this.textUnSelectedStyle,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? backgroundColor : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
      child: Text(
        name,
        style: isSelected ? textSelectedStyle : textUnSelectedStyle,
      ),
    );
  }
}
