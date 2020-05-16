import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_destinations/constants/custom_colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    final double _horizontalSpace = MediaQuery.of(context).size.width * 0.05;
    final double _verticalSpace = MediaQuery.of(context).size.height * 0.08;
    final double _iconsSize = 30.0;

    return Scaffold(
        backgroundColor: BaseColors.background,
        body: Container(
          alignment: Alignment.topCenter,
          // color: BaseColors.favorite,
          padding: EdgeInsets.only(
            left: _horizontalSpace,
            top: _verticalSpace,
            bottom: _verticalSpace,
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 60.0,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(right: _horizontalSpace),
                padding: EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                  color: BaseColors.white,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Find trips ...',
                    hintStyle: TextStyle(
                      color: BaseColors.lightBlack,
                      fontSize: 18.0,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: BaseColors.main,
                      size: _iconsSize,
                    ),
                    suffixIcon: Icon(
                      Icons.menu,
                      size: _iconsSize,
                      color: BaseColors.textBlack,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.040,
              ),
              Text(
                'Hi, Nancy :)',
              ),
            ],
          ),
        ));
  }
}
