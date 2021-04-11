import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget cardChild;
  final Function onTape;

  const ReusableCard({@required this.color, this.cardChild, this.onTape});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTape,
      child: Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: cardChild,
      ),
    );
  }
}
