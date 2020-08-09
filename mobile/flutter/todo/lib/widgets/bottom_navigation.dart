import 'package:flutter/material.dart';
import 'package:todo/constants/nav_items.dart';

class BottomNavigation extends StatelessWidget {
  final int navIndex;
  final Function onTap;

  BottomNavigation({Key key, this.navIndex, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: navItems
          .map((item) => BottomNavigationBarItem(
              icon: Icon(item['icon']), title: Text(item['title'])))
          .toList(),
      currentIndex: navIndex,
      onTap: onTap,
    );
  }
}
