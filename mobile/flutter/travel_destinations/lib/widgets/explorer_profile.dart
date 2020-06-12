import 'package:flutter/material.dart';
import 'package:travel_destinations/constants/custom_colors.dart';
import 'package:travel_destinations/models/destination_model.dart';

class ExplorerProfile extends StatelessWidget {
  final Destinations destination;
  final double nocheSize;
  final double borderSize;
  final double profileSize;
  final double profileContainerHeight;
  final double profileContainerWidth;
  final double moreUserTextSize;

  ExplorerProfile({
    this.destination,
    this.nocheSize,
    this.borderSize,
    this.profileSize,
    this.profileContainerHeight,
    this.profileContainerWidth: 0.0,
    this.moreUserTextSize,
  });

  @override
  Widget build(BuildContext context) {
    double _initialMargin = 0.0;
    double _marginToAdd = nocheSize;

    final List<Widget> explorers = [];
    final _explorersList = destination.explorers.take(2);

    final BoxDecoration _decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        color: BaseColors.white,
        width: borderSize,
      ),
    );

    for (var i = 0; i < _explorersList.length + 1; i++) {
      final explorer = Positioned(
        left: _initialMargin,
        child: Container(
          width: profileSize,
          height: profileSize,
          decoration: _decoration,
          child: _BuildExplorerAvatar(
            destination.explorers,
            _explorersList.length,
            i,
            moreUserTextSize,
          ),
        ),
      );

      explorers.add(explorer);

      _initialMargin += _marginToAdd;
    }

    final _profiles = Container(
      // color: BaseColors.favorite,
      height: profileContainerHeight,
      width: profileContainerWidth > .0 ? profileContainerWidth : null,
      child: Stack(children: explorers),
    );

    return (profileContainerWidth == .0)
        ? Expanded(child: _profiles)
        : _profiles;
  }
}

class _BuildExplorerAvatar extends StatelessWidget {
  final List<String> _explorers;
  final int _slicedExplorerLength;
  final int _index;
  final double _moreUserTextSize;

  _BuildExplorerAvatar(
    this._explorers,
    this._slicedExplorerLength,
    this._index,
    this._moreUserTextSize,
  );

  @override
  Widget build(__) {
    if (_index < _slicedExplorerLength) {
      return CircleAvatar(
        backgroundImage:
            AssetImage('assets/images/explorers/${_explorers[_index]}.jpg'),
      );
    }

    final _style = TextStyle(
      fontSize: _moreUserTextSize,
      fontWeight: FontWeight.bold,
      color: BaseColors.main,
    );

    return CircleAvatar(
      child: Text('+${_explorers.length - 2}', style: _style),
      backgroundColor: BaseColors.mainLight,
    );
  }
}
