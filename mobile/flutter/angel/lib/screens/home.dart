import 'package:angel/widgets/home_screen/user_card.dart';
import 'package:flutter/material.dart';
import 'package:angel/common/colors/custom_colors.dart';
import 'package:angel/widgets/home_screen/top_bar.dart';
import 'package:angel/widgets/home_screen/search_bar.dart';
import 'package:angel/widgets/home_screen/services.dart';
import 'package:angel/widgets/home_screen/categories.dart';
import 'package:angel/model/users_model.dart';

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
              _buildSectionTitle(
                context: context,
                title: 'Services',
                linkUrl: 'services',
              ),
              SizedBox(height: 10),
              Services(),
              SizedBox(height: 25),
              _buildSectionTitle(
                context: context,
                title: 'Categories',
                linkUrl: 'categories',
              ),
              SizedBox(height: 10.0),
              Categories(),
              SizedBox(height: 25.0),
              _buildSectionTitle(
                context: context,
                title: 'Freelancers',
                linkUrl: 'freelancers',
              ),
              SizedBox(height: 10.0),
              UsersCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle({
    BuildContext context,
    String title,
    String linkUrl,
    String linkText: 'See all',
  }) {
    return Container(
      margin: EdgeInsets.only(right: _margin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: BaseColors.blackText,
            ),
          ),
          GestureDetector(
            child: Text(
              '$linkText',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: BaseColors.link,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/$linkUrl');
            },
          ),
        ],
      ),
    );
  }
}
