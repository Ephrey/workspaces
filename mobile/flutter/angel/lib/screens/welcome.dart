import 'package:flutter/material.dart';
import 'package:angel/common/colors/custom_colors.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.welcomeBackground,
      body: Container(
        child: Column(
          children: <Widget>[
            _buildTitle(),
            _buildIllustration(),
            _buildTextDescription(),
            _buildDot(),
            _buildContinueButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 60, 10, 20),
      child: Text(
        'angel',
        style: TextStyle(
          fontSize: 70,
          fontWeight: FontWeight.w100,
          color: BaseColors.blackText,
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/home_illustration__.png',
        width: 355.0,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTextDescription() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 40, 10, 13),
            child: Text(
              'Housekeeping Service',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'from over 10.000 professional \n freelancers',
              softWrap: true,
              style: TextStyle(
                color: BaseColors.subText,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _dot(BaseColors.blackText),
          _dot(),
          _dot(),
        ],
      ),
    );
  }

  Widget _dot([color = Colors.grey]) {
    return Container(
      margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
      child: null,
    );
  }

  Widget _buildContinueButton(context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
      child: GestureDetector(
        child: Container(
          width: 250,
          height: 65,
          padding: EdgeInsets.only(left: 30.0),
          decoration: BoxDecoration(
            color: BaseColors.continueButtonBackground,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              topLeft: Radius.circular(5.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Continue',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 50,
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/home');
        },
      ),
    );
  }
}
