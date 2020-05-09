import 'package:flutter/material.dart';
import 'package:angel/common/colors/custom_colors.dart';

class SearchBar extends StatelessWidget {
  static const double _margin = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: _margin),
      child: Row(
        children: <Widget>[
          _buildSearchBar(),
          _buildSearchSetting(),
        ],
      ),
    );
  }

  _buildSearchBar() {
    return Expanded(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          // color: Colors.green,
          border: Border.all(color: BaseColors.borderLight),
          borderRadius: BorderRadius.all(
            Radius.elliptical(10, 10),
          ),
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.search,
              color: BaseColors.icons,
            ),
            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            hintText: 'Search an angel ...',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSetting() {
    return Container(
      width: 60,
      height: 40,
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        border: Border.all(color: BaseColors.borderLight),
        borderRadius: BorderRadius.all(
          Radius.elliptical(10, 10),
        ),
      ),
      child: Icon(
        Icons.tune,
        size: 25,
        color: BaseColors.icons,
      ),
    );
  }
}
