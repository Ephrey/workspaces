import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_destinations/constants/custom_colors.dart';
import 'package:travel_destinations/screens/home.dart';
import 'package:travel_destinations/utils/custom_route_builder.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext _context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final _deviceState = MediaQuery.of(context);
    final _deviceScreenSize = _deviceState.size;
    final _deviceOrientation = _deviceState.orientation;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBackgroundImage(),
          _buildOverLayContainer(
            _context,
            _deviceScreenSize,
            _deviceOrientation,
          ),
        ],
      ),
    );
  }

  Widget _buildOverLayContainer(
    _context,
    _deviceScreenSize,
    _deviceOrientation,
  ) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.symmetric(
        horizontal: _deviceScreenSize.width * 0.05,
        vertical: _deviceScreenSize.height * 0.10,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.center,
          colors: [
            BaseColors.darkBlack.withOpacity(0.9),
            // BaseColors.darkBlack.withOpacity(0.7),
            // BaseColors.darkBlack.withOpacity(0.6),
            BaseColors.darkBlack.withOpacity(0.0),
          ],
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _buildTextBloc(
          _context,
          _deviceScreenSize,
          _deviceOrientation,
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset('assets/images/home/cover.jpg', fit: BoxFit.cover),
    );
  }

  Widget _buildTextBloc(
    BuildContext _context,
    _deviceScreenSize,
    _deviceOrientation,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMainTitle(
          _context,
          _deviceScreenSize,
          _deviceOrientation,
        ),
        SizedBox(
          height: _deviceScreenSize.height * 0.02,
        ),
        _buildMainTitleSubText(
          _context,
          _deviceScreenSize,
          _deviceOrientation,
        ),
        SizedBox(
          height: _deviceScreenSize.height * 0.06,
        ),
        _buildButton(
          _context,
          _deviceScreenSize,
          _deviceOrientation,
        ),
      ],
    );
  }

  Widget _buildMainTitle(
    BuildContext _context,
    _deviceScreenSize,
    _deviceOrientation,
  ) {
    return Text(
      'Enjoy The World',
      style: TextStyle(
        color: BaseColors.white,
        fontSize: _deviceOrientation == Orientation.portrait
            ? _deviceScreenSize.width * 0.10
            : _deviceScreenSize.height * 0.15,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildMainTitleSubText(
    BuildContext _context,
    _deviceScreenSize,
    _deviceOrientation,
  ) {
    return Text(
      'From Cape Town to Durban, South Africa is alive',
      style: TextStyle(
        color: BaseColors.white,
        fontSize: _deviceOrientation == Orientation.portrait
            ? _deviceScreenSize.width * 0.06
            : _deviceScreenSize.height * 0.08,
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
    );
  }

  Widget _buildButton(
    BuildContext _,
    _deviceScreenSize,
    _deviceOrientation,
  ) {
    return Container(
      height: _deviceOrientation == Orientation.portrait
          ? _deviceScreenSize.height * 0.10
          : _deviceScreenSize.width * 0.08,
      width: double.infinity,
      decoration: BoxDecoration(
        color: BaseColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: FlatButton(
        child: Text(
          'Discover',
          style: TextStyle(
            color: BaseColors.main,
            fontSize: _deviceOrientation == Orientation.portrait
                ? _deviceScreenSize.width * 0.05
                : _deviceScreenSize.height * 0.05,
            fontWeight: FontWeight.w800,
          ),
        ),
        onPressed: () => Navigator.push(_, buildCustomRoute(Home())),
      ),
    );
  }
}
