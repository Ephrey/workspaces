import 'package:angel/common/colors/custom_colors.dart';
import 'package:flutter/material.dart';

class ServiceIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  ServiceIcon({Key key, this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      margin: EdgeInsets.only(top: 18.0, bottom: 15.0),
      decoration: BoxDecoration(
        color: BaseColors.welcomeBackground,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Icon(
        icon,
        size: 35.0,
        color: color,
      ),
    );
  }
}
