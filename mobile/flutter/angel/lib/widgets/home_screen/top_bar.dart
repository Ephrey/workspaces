import 'package:flutter/material.dart';
import 'package:angel/common/colors/custom_colors.dart';

class TopBar extends StatelessWidget {
  static const double _margin = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: _margin),
      child: Row(
        children: <Widget>[
          Text(
            'Find angels',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          _buildProfileImageAndUserStatusIcons(),
        ],
      ),
    );
  }

  Widget _buildProfileImageAndUserStatusIcons() {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                _buildProfileImage(),
                _buildUserStatusIcon(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      alignment: Alignment.centerRight,
      width: 45,
      height: 45,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/users/profile_pictures/nancy.png'),
        radius: 100,
      ),
    );
  }

  _buildUserStatusIcon() {
    return Container(
      alignment: Alignment.center,
      width: 15.0,
      height: 15.0,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: BaseColors.whiteBackground,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Icon(
        Icons.brightness_1,
        color: BaseColors.active,
        size: 13.0,
      ),
    );
  }
}
