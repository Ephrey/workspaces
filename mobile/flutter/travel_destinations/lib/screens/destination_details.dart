import 'package:flutter/material.dart';
import 'package:travel_destinations/constants/custom_colors.dart';
import 'package:travel_destinations/models/destination_model.dart';
import 'package:travel_destinations/utils/custom_position_animation.dart';
import 'package:travel_destinations/utils/custom_transform_animation.dart';
import 'package:travel_destinations/widgets/departure_time.dart';
import 'package:travel_destinations/widgets/location_name.dart';
import 'package:travel_destinations/widgets/destination_name.dart';
import 'package:travel_destinations/widgets/explorer_leading_icon.dart';
import 'package:travel_destinations/widgets/explorer_profile.dart';
import 'package:travel_destinations/widgets/favorite_icon.dart';
import 'package:travel_destinations/widgets/location_icon.dart';

class DestinationDetails extends StatefulWidget {
  final Destinations destination;
  DestinationDetails({Key key, this.destination}) : super(key: key);

  @override
  _DestinationDetailsState createState() => _DestinationDetailsState();
}

class _DestinationDetailsState extends State<DestinationDetails> {
  void handleFavorite(isFav) {
    setState(() {
      widget.destination.isFavorite = isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _device = MediaQuery.of(context);
    final Size _deviceScreenSize = _device.size;
    final double _heroHeight = _deviceScreenSize.height * .40;

    final Column _destinationDetails = Column(
      children: <Widget>[
        _BuildHeroSection(
          widget.destination,
          _deviceScreenSize,
          _heroHeight,
          handleFavorite,
        ),
        CustomTransformAnimation(
          child: _BuildDestinationMoreInfo(
            widget.destination,
            _deviceScreenSize,
          ),
          translationY: -50.0,
          duration: Duration(milliseconds: 900),
          intervalBegin: .1,
          curve: Curves.easeOutBack,
        ),
        _BuildDestinationDescription(
          widget.destination,
          _deviceScreenSize,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: BaseColors.background,
      body: _destinationDetails,
      floatingActionButton: CustomTransformAnimation(
        child: _BuildFloatingButton(_deviceScreenSize),
        translationY: -200.0,
        curve: Curves.easeOutBack,
        duration: Duration(milliseconds: 900),
        intervalBegin: .7,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _BuildDestinationMoreInfo extends StatelessWidget {
  final Destinations _destination;
  final Size _screenSize;

  _BuildDestinationMoreInfo(this._destination, this._screenSize);

  @override
  Widget build(_) {
    final double _horizontalMargin = _screenSize.width * .04;
    final double _verticalMargin = _screenSize.height * .01;

    final _decoration = BoxDecoration(
      color: BaseColors.white,
      borderRadius: BorderRadius.circular(10.0),
    );

    final Container _moreInfo = Container(
      height: _screenSize.height * .09,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(
        _horizontalMargin,
        _verticalMargin,
        _horizontalMargin,
        _verticalMargin + 10.0,
      ),
      padding: EdgeInsets.all(_horizontalMargin / 5),
      decoration: _decoration,
      child: LayoutBuilder(
        builder: (_, constraints) {
          final double _parentHeight = constraints.maxHeight;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _BuildExplorers(_destination, _parentHeight),
              _BuildSeparator(height: _parentHeight * .50),
              _BuildDepartureTime(_destination, _parentHeight),
            ],
          );
        },
      ),
    );

    return _moreInfo;
  }
}

class _BuildExplorers extends StatelessWidget {
  final Destinations _destination;
  final double _parentHeight;

  _BuildExplorers(this._destination, this._parentHeight);

  @override
  Widget build(_) {
    final double height = _parentHeight * .48;

    final List<Widget> _explorers = <Widget>[
      LeadingIcon(size: _parentHeight * .43),
      SizedBox(width: _parentHeight * .07),
      ExplorerProfile(
        destination: _destination,
        nocheSize: _parentHeight * .3 + 2.0,
        borderSize: _parentHeight * .03,
        profileSize: height,
        profileContainerHeight: height,
        profileContainerWidth: (height * 2.3),
        moreUserTextSize: _parentHeight * .2,
      ),
    ];

    return Row(children: _explorers);
  }
}

class _BuildSeparator extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  _BuildSeparator({
    this.height,
    this.width: 1.0,
    this.color: BaseColors.separator,
  });

  @override
  Widget build(_) {
    return Container(width: width, height: height, color: color);
  }
}

class _BuildDepartureTime extends StatelessWidget {
  final Destinations _destination;
  final double _parentHeight;

  _BuildDepartureTime(this._destination, this._parentHeight);

  @override
  Widget build(_) {
    return DepartureTime(
      time: '${_destination.when}',
      fontSize: _parentHeight * .2,
      iconSize: _parentHeight * .4,
    );
  }
}

class _BuildDestinationDescription extends StatelessWidget {
  final Destinations _destination;
  final Size _screenSize;

  _BuildDestinationDescription(this._destination, this._screenSize);

  @override
  Widget build(_) {
    double _padding = _screenSize.width * .04;

    final _description = SingleChildScrollView(
      padding: EdgeInsets.only(bottom: _screenSize.height * .17),
      child: Text(
        '${_destination.description}',
        style: TextStyle(fontSize: 16.0, height: 1.7),
      ),
    );

    return Expanded(
      flex: 2,
      child: CustomTransformAnimation(
        child: Container(
          padding: EdgeInsets.only(left: _padding, right: _padding),
          child: _description,
        ),
        translationY: 18.0,
        duration: Duration(milliseconds: 700),
        curve: Curves.easeOutBack,
        intervalBegin: .3,
      ),
    );
  }
}

class _BuildHeroSection extends StatelessWidget {
  final Destinations _destination;
  final Size _deviceScreenSize;
  final double _heroHeight;
  final Function(bool) handleFavorite;

  _BuildHeroSection(
    this._destination,
    this._deviceScreenSize,
    this._heroHeight,
    this.handleFavorite,
  );

  @override
  Widget build(_) {
    final _heroInfo = Stack(
      children: <Widget>[
        _BuildBackIcon(_deviceScreenSize),
        _BuildGradientBackground(_deviceScreenSize),
        CustomPositionAnimation(
          child: _BuildDestinationInfo(
            _destination,
            _deviceScreenSize,
            _heroHeight,
          ),
          beginLeft: -200.0,
          endLeft: _deviceScreenSize.width * .04,
        ),
        CustomPositionAnimation(
          child: _BuildFavoriteIcon(
            _destination,
            _deviceScreenSize,
            _heroHeight,
            handleFavorite,
          ),
          beginRight: -70.0,
          endRight: _deviceScreenSize.width * .04,
          curve: Curves.bounceInOut,
        ),
      ],
    );

    final _decoration = BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/destinations/${_destination.image}'),
        fit: BoxFit.cover,
      ),
    );

    return Container(
      decoration: _decoration,
      width: double.infinity,
      height: _heroHeight,
      child: _heroInfo,
    );
  }
}

class _BuildBackIcon extends StatelessWidget {
  final Size _deviceScreenSize;

  _BuildBackIcon(this._deviceScreenSize);

  @override
  Widget build(BuildContext context) {
    final _marginTop = _deviceScreenSize.height * .05;
    final _marginLeft = _deviceScreenSize.width * .03;

    final _icon = GestureDetector(
      child: Icon(
        Icons.arrow_back,
        size: _deviceScreenSize.width * .09,
        color: BaseColors.white,
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );

    return Positioned(top: _marginTop, left: _marginLeft, child: _icon);
  }
}

class _BuildDestinationInfo extends StatelessWidget {
  final Destinations _destination;
  final Size _deviceScreenSize;
  final double _heroHeight;

  _BuildDestinationInfo(
    this._destination,
    this._deviceScreenSize,
    this._heroHeight,
  );

  @override
  Widget build(_) {
    final _info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _BuildLocationName(_destination, _deviceScreenSize),
        SizedBox(height: 4.0),
        _BuildDestinationName(_destination, _deviceScreenSize),
      ],
    );

    return _info;
  }
}

class _BuildLocationName extends StatelessWidget {
  final Destinations _destination;
  final Size _deviceScreenSize;

  _BuildLocationName(this._destination, this._deviceScreenSize);

  @override
  Widget build(_) {
    final _name = LocationName(
      name: "${_destination.location}",
      fontSize: _deviceScreenSize.width * .04,
      fontColor: BaseColors.textBlack,
    );

    return Row(
      children: <Widget>[
        LocationIcon(iconSize: _deviceScreenSize.width * .04 + 4),
        SizedBox(width: 3.0),
        _name
      ],
    );
  }
}

class _BuildDestinationName extends StatelessWidget {
  final Destinations _destination;
  final Size _deviceScreenSize;

  _BuildDestinationName(this._destination, this._deviceScreenSize);

  @override
  Widget build(_) {
    return DestinationName(
      name: "${_destination.name}",
      size: _deviceScreenSize.width * .07,
      color: BaseColors.darkBlack,
    );
  }
}

class _BuildFavoriteIcon extends StatelessWidget {
  final Destinations _destination;
  final Size _deviceScreenSize;
  final double _parentHeight;
  final Function(bool) handleFavorite;

  _BuildFavoriteIcon(
    this._destination,
    this._deviceScreenSize,
    this._parentHeight,
    this.handleFavorite,
  );

  @override
  Widget build(_) {
    final _icon = FavoriteIcon(
      iconSize: _deviceScreenSize.width * .08,
      iconContainerSize: _deviceScreenSize.width * .13,
      isFavorite: _destination.isFavorite,
      withShadow: true,
      onIconTapped: handleFavorite,
    );

    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: _parentHeight * .02),
        child: _icon,
      ),
    );
  }
}

class _BuildGradientBackground extends StatelessWidget {
  final Size _deviceScreenSize;

  _BuildGradientBackground(this._deviceScreenSize);

  @override
  Widget build(_) {
    final List<Color> _gradientColors = <Color>[
      BaseColors.background.withOpacity(.0),
      BaseColors.background.withOpacity(.1),
      BaseColors.background.withOpacity(.5),
      BaseColors.background.withOpacity(.7),
      BaseColors.background.withOpacity(.9),
      BaseColors.background,
      BaseColors.background,
    ];

    final _boxDecoration = BoxDecoration(
      color: BaseColors.favorite,
      gradient: LinearGradient(
        colors: _gradientColors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );

    final _gradient = Container(
      height: _deviceScreenSize.height * .15,
      width: _deviceScreenSize.width,
      alignment: Alignment.bottomCenter,
      decoration: _boxDecoration,
    );

    return Positioned(bottom: -2.0, left: .0, child: _gradient);
  }
}

class _BuildFloatingButton extends StatelessWidget {
  final Size _deviceScreenSize;

  _BuildFloatingButton(this._deviceScreenSize);

  @override
  Widget build(_) {
    final _buttonText = LayoutBuilder(
      builder: (_, constraints) {
        final _style = TextStyle(
          color: BaseColors.white,
          fontWeight: FontWeight.w700,
          fontSize: constraints.maxHeight * .22,
        );

        return FlatButton(
          child: Text('Book this Trip', style: _style),
          onPressed: () => print('Hello :)'),
        );
      },
    );

    return Container(
      width: _deviceScreenSize.width * .92,
      height: _deviceScreenSize.height * 0.09 + 2,
      margin: EdgeInsets.only(bottom: _deviceScreenSize.height * 0.02),
      decoration: BoxDecoration(
        color: BaseColors.main,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: _buttonText,
    );
  }
}
