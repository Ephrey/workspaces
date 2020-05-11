import 'package:angel/common/colors/custom_colors.dart';
import 'package:flutter/material.dart';

class SectionTitleAndLink extends StatelessWidget {
  final String title;
  final String linkUrl;
  final String linkText;

  SectionTitleAndLink(
      {Key key, this.title, this.linkUrl, this.linkText: "See all"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildSectionTitleAndTitle(
      context: context,
      title: title,
      linkUrl: linkUrl,
      linkText: linkText,
    );
  }

  Widget _buildSectionTitleAndTitle({
    BuildContext context,
    String title,
    String linkUrl,
    String linkText,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildTitle(title: title),
          _buildLink(context: context, linkText: linkText, linkUrl: linkUrl),
        ],
      ),
    );
  }

  Widget _buildTitle({String title}) {
    return Text(
      '$title',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: BaseColors.blackText,
      ),
    );
  }

  Widget _buildLink({BuildContext context, String linkText, String linkUrl}) {
    return GestureDetector(
      child: Text(
        '$linkText',
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: BaseColors.link,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/$linkUrl');
      },
    );
  }
}
