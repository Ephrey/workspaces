import 'package:flutter/material.dart';
import 'package:angel/common/colors/custom_colors.dart';
import 'package:angel/model/users_model.dart';

class BabySitterCards extends StatelessWidget {
  final List<UsersModel> babySitters;

  BabySitterCards({Key key, @required this.babySitters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (babySitters != null) print(babySitters[0].name);
    return Container(
      padding:
          EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
      child: LayoutBuilder(
        builder: (context, constraint) {
          final double width = constraint.maxWidth;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildBabySittingCard(
              parentWidth: width,
              babySitters: babySitters,
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildBabySittingCard({
    double parentWidth,
    List<UsersModel> babySitters,
  }) {
    List<Widget> cards = [];

    for (var i = 0; i < babySitters.length; i++) {
      UsersModel babySitter = babySitters[i];

      final card = Container(
        width: (parentWidth / 2) - 5,
        height: 275,
        decoration: BoxDecoration(
          color: BaseColors.whiteBackground,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 7.0,
              offset: Offset(0.0, 4.0),
              color: BaseColors.shadow,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            _buildProfileAndFavoriteIcon(user: babySitter),
            _buildName(user: babySitter),
            _buildRatingTextAndIcon(user: babySitter),
            _buildRate(user: babySitter),
          ],
        ),
      );

      cards.add(card);
    }

    return cards;
  }

  Widget _buildProfileAndFavoriteIcon({UsersModel user}) {
    return Container(
      height: 190.0,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topRight,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7.0),
              topRight: Radius.circular(7.0),
            ),
            child: Image.asset(
              'assets/users/profile_pictures/${user.profilePicture}.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0.0,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                user.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: user.isFavorite
                    ? BaseColors.favorite
                    : BaseColors.whiteBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingTextAndIcon({UsersModel user}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.star,
            size: 17.0,
            color: BaseColors.rate,
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.0),
            child: Text(
              '${user.rating}',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: BaseColors.subText,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildName({UsersModel user}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10.0),
      child: Text(
        '${user.name}',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildRate({UsersModel user}) {
    return Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.only(right: 10.0),
      child: Text(
        '${user.rate}',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: BaseColors.blackText,
        ),
      ),
    );
  }
}
