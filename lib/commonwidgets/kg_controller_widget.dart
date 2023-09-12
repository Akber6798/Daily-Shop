import 'package:daily_shop/consts/app_colors.dart';
import 'package:flutter/material.dart';

class KGControllerWidget extends StatelessWidget {
  const KGControllerWidget(
      {super.key,
      required this.color,
      required this.clickedFunction,
      required this.icon});

  final Color color;
  final Function clickedFunction;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          clickedFunction();
        },
        child: Icon(
          icon,
          color: whiteColor,
        ),
      ),
    );
  }
}
