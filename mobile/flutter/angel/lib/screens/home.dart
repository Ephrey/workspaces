import 'package:flutter/material.dart';
import 'package:angel/common/colors/custom_colors.dart';
import 'package:angel/widgets/section_title_and_link.dart';
import 'package:angel/widgets/home_screen/top_bar.dart';
import 'package:angel/widgets/home_screen/search_bar.dart';
import 'package:angel/widgets/home_screen/services.dart';
import 'package:angel/widgets/home_screen/categories.dart';
import 'package:angel/widgets/home_screen/user_card.dart';

class Home extends StatelessWidget {
  static const double _margin = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.whiteBackground,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: _margin, top: 60),
          child: Column(
            children: <Widget>[
              TopBar(),
              SizedBox(height: 40),
              SearchBar(),
              SizedBox(height: 35),
              SectionTitleAndLink(title: 'Services', linkUrl: 'services'),
              SizedBox(height: 10),
              Services(),
              SizedBox(height: 25),
              SectionTitleAndLink(title: 'Categories', linkUrl: 'categories'),
              SizedBox(height: 10.0),
              Categories(),
              SizedBox(height: 25.0),
              SectionTitleAndLink(title: 'Freelancers', linkUrl: 'freelancers'),
              SizedBox(height: 10.0),
              UsersCard(),
            ],
          ),
        ),
      ),
    );
  }
}
