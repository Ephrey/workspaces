import 'package:flutter/material.dart';
import 'package:angel/common/colors/custom_colors.dart';
import 'package:angel/model/users_model.dart';

class UsersCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildUserInfoCards(context);
  }

  Widget _buildUserInfoCards(context) {
    List<Widget> cards = <Widget>[];

    for (var i = 0; i < usersModel.length; i++) {
      final UsersModel user = usersModel[i];

      final card = GestureDetector(
        child: Container(
          margin: EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
          height: 110.0,
          decoration: BoxDecoration(
            color: BaseColors.whiteBackground,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                spreadRadius: 5.0,
                offset: Offset(0.0, 4.0),
                color: BaseColors.welcomeBackground,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              _buildCardProfileImage(user: user),
              _buildUserInfo(user: user),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/user',
            arguments: {'userId': i},
          );
        },
      );

      cards.add(card);
    }

    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: cards,
      ),
    );
  }

  Widget _buildCardProfileImage({UsersModel user}) {
    return Container(
      width: 110.0,
      height: 110.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          'assets/users/profile_pictures/${user.profilePicture}.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildUserInfo({UsersModel user}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildUserNameAndJobTitle(user: user),
            _buildUserMoreInfo(user: user),
          ],
        ),
      ),
    );
  }

  Widget _buildUserNameAndJobTitle({UsersModel user}) {
    return RichText(
      text: TextSpan(
        text: '${user.name} \n',
        style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
          color: BaseColors.blackText,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '${user.jobTitle}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: BaseColors.subText,
              height: 1.5,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUserMoreInfo({UsersModel user}) {
    return Container(
      margin: EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildUserMoreInfoRating(mainLabel: 'Rating', subLabel: user.rating),
          _buildUserMoreInfoText(mainLabel: 'Job', subLabel: user.jobCount),
          _buildUserMoreInfoText(mainLabel: 'Rate', subLabel: user.rate),
        ],
      ),
    );
  }

  Widget _buildUserMoreInfoRating({String mainLabel, dynamic subLabel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$mainLabel',
          style: TextStyle(
            color: BaseColors.blackText,
            fontWeight: FontWeight.w800,
          ),
        ),
        _buildRating(subLabel),
      ],
    );
  }

  Widget _buildRating(rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.star,
          size: 14.5,
          color: BaseColors.rate,
        ),
        SizedBox(width: 2.0),
        Text(
          '$rating',
          style: TextStyle(
            color: BaseColors.subText,
            height: 1.5,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildUserMoreInfoText({String mainLabel, dynamic subLabel}) {
    return Column(
      children: <Widget>[
        Text(
          '$mainLabel',
          style: TextStyle(
            color: BaseColors.blackText,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          '$subLabel',
          style: TextStyle(
            color: BaseColors.subText,
            height: 1.5,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
