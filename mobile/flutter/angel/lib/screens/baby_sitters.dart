import 'package:angel/model/users_model.dart';
import 'package:angel/widgets/baby_sitting/baby_sitter_cards.dart';
import 'package:flutter/material.dart';
import 'package:angel/common/colors/custom_colors.dart';
import 'package:angel/widgets/section_title_and_link.dart';
import 'package:angel/widgets/service_icon.dart';

class BabySitters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.whiteBackground,
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 200.0),
              child: Container(
                  // color: Colors.green,
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: SectionTitleAndLink(
                      title: 'The Best Babysitters',
                      linkUrl: 'best_baby_sitters',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  BabySitterCards(babySitters: babySitters),
                  SizedBox(height: 25.0),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: SectionTitleAndLink(
                      title: 'Recommended',
                      linkUrl: 'best_baby_sitters',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  BabySitterCards(babySitters: recommendedBabySitters),
                ],
              )),
            ),
          ),
          Stack(
            alignment: Alignment(0.0, 2.2),
            children: <Widget>[
              Container(
                height: 150.0,
                padding: EdgeInsets.only(top: 10.0),
                color: BaseColors.babySitter,
                alignment: Alignment.center,
                child: Text(
                  'Babysitting Services',
                  style: TextStyle(
                    color: BaseColors.whiteBackground,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ServiceIcon(
                icon: Icons.child_friendly,
                color: BaseColors.babySitter,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fiber_manual_record),
            title: Text('Discover'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sentiment_satisfied),
            title: Text('Profile'),
          ),
        ],
        currentIndex: 1,
        backgroundColor: BaseColors.whiteBackground,
        elevation: 4.0,
        selectedFontSize: 15.0,
        selectedIconTheme: IconThemeData(size: 32.0),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        selectedItemColor: BaseColors.babySitter,
        unselectedFontSize: 15.0,
        unselectedIconTheme: IconThemeData(
          size: 30.0,
          color: BaseColors.subText,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
