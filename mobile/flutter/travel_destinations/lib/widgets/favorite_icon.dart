import 'package:flutter/material.dart';
import 'package:travel_destinations/constants/custom_colors.dart';
import 'package:travel_destinations/utils/custom_scale_animation.dart';

class FavoriteIcon extends StatefulWidget {
  final double iconSize;
  final double iconContainerSize;
  final bool isFavorite;
  final ValueChanged<bool> onIconTapped;
  final bool withShadow;

  FavoriteIcon({
    Key key,
    @required this.iconSize,
    @required this.iconContainerSize,
    this.onIconTapped,
    this.isFavorite: false,
    this.withShadow: false,
  }) : super(key: key);

  FavoriteIconState createState() => FavoriteIconState();
}

class FavoriteIconState extends State<FavoriteIcon> {
  bool tapped = false;

  void _handleIconTap() {
    widget.onIconTapped(!widget.isFavorite);
    tapped = !tapped;
  }

  @override
  Widget build(BuildContext context) {
    final _favoriteIcon = Icon(
      widget.isFavorite ? Icons.favorite : Icons.favorite_border,
      color: BaseColors.favorite,
      size: widget.isFavorite
          ? widget.iconSize + widget.iconContainerSize * .1
          : widget.iconSize,
    );

    final _shadow = [
      BoxShadow(
        blurRadius: 1.5,
        offset: Offset(.0, 2.5),
        color: BaseColors.separator,
        spreadRadius: 1.5,
      )
    ];

    final _decoration = BoxDecoration(
      color: BaseColors.white,
      borderRadius: BorderRadius.circular(100),
      boxShadow: widget.withShadow ? _shadow : null,
    );

    final _icon = Container(
      width: widget.iconContainerSize,
      height: widget.iconContainerSize,
      decoration: _decoration,
      child: Center(
        child: _favoriteIcon,
      ),
    );

    return GestureDetector(
      child: !tapped
          ? _icon
          : CustomScaleAnimation(
              child: _icon,
              begin: widget.iconContainerSize,
            ),
      onTap: _handleIconTap,
    );
  }
}
