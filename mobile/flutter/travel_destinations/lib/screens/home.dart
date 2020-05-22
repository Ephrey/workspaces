import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_destinations/constants/activities.dart';
import 'package:travel_destinations/constants/custom_colors.dart';
import 'package:travel_destinations/constants/navigation.dart';
import 'package:travel_destinations/models/destination_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _activeNavigatorIndex = 0;

  void _setActiveNavigation(index) {
    setState(() {
      _activeNavigatorIndex = index;
    });
  }

  @override
  Widget build(BuildContext _context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    final _deviceState = MediaQuery.of(_context);
    final _deviceScreenSize = _deviceState.size;
    // final _deviceOrientation = _deviceState.orientation;

    final double _horizontalSpace = _deviceScreenSize.width * 0.05;
    final double _verticalSpace = _deviceScreenSize.height * 0.06;
    final double _iconSize = _deviceScreenSize.width * 0.08;

    return Scaffold(
      backgroundColor: BaseColors.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
            left: _horizontalSpace,
            top: _verticalSpace,
            bottom: _verticalSpace,
          ),
          child: Column(
            children: <Widget>[
              _BuildUserGreeting(_deviceScreenSize, _horizontalSpace),
              SizedBox(height: _deviceScreenSize.height * 0.030),
              _BuildSearchBar(_deviceScreenSize, _horizontalSpace, _iconSize),
              SizedBox(height: _deviceScreenSize.height * 0.030),
              _BuildActivities(_deviceScreenSize),
              SizedBox(height: _deviceScreenSize.height * 0.015),
              _BuildSeparator(_horizontalSpace),
              SizedBox(height: _deviceScreenSize.height * 0.025),
              _BuildNavigation(
                _horizontalSpace,
                _deviceScreenSize,
                _activeNavigatorIndex,
                _setActiveNavigation,
              ),
              SizedBox(height: _deviceScreenSize.height * 0.020),
              _BuildDestinationCards(
                _deviceScreenSize,
                destinations,
                _activeNavigatorIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildActivities extends StatelessWidget {
  final Size _deviceScreenSize;

  _BuildActivities(this._deviceScreenSize);

  @override
  Widget build(_) {
    return Container(
      height: _deviceScreenSize.height * 0.22,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: activities.length,
        itemBuilder: (_, i) {
          return _BuildActivity(activities[i], _deviceScreenSize);
        },
      ),
    );
  }
}

class _BuildActivity extends StatelessWidget {
  final Activities _activity;
  final Size _deviceScreenSize;

  _BuildActivity(this._activity, this._deviceScreenSize);

  @override
  Widget build(_) {
    final _activityBloc = LayoutBuilder(
      builder: (_, constraint) {
        final _parentHeight = constraint.maxHeight;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _BuildActivityIcon(_activity, _parentHeight),
            _BuildActivityName(_activity, _parentHeight),
          ],
        );
      },
    );

    return Container(
      width: _deviceScreenSize.width * 0.35,
      margin: EdgeInsets.only(right: 13.0),
      child: _activityBloc,
    );
  }
}

class _BuildActivityIcon extends StatelessWidget {
  final Activities _activity;
  final double _parentHeight;

  _BuildActivityIcon(this._activity, this._parentHeight);

  Widget build(_) {
    final _decoration = BoxDecoration(
      color: BaseColors.white,
      borderRadius: BorderRadius.circular(15.0),
    );

    final _icon = Center(
      child: Icon(
        _activity.icon,
        size: _parentHeight * 0.28,
        color: BaseColors.main,
      ),
    );

    return Container(
      decoration: _decoration,
      height: _parentHeight * 0.70,
      child: _icon,
    );
  }
}

class _BuildActivityName extends StatelessWidget {
  final Activities _activity;
  final double _parentHeight;

  _BuildActivityName(this._activity, this._parentHeight);

  Widget build(_) {
    final _style = TextStyle(
      color: BaseColors.textBlack,
      fontSize: _parentHeight * .09,
      fontWeight: FontWeight.w700,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: _parentHeight * .09),
      child: Text('${_activity.name}', style: _style),
    );
  }
}

class _BuildSeparator extends StatelessWidget {
  final double _horizontalSpace;

  _BuildSeparator(this._horizontalSpace);

  @override
  Widget build(_) {
    return Container(
      height: 1.0,
      color: BaseColors.separator,
      margin: EdgeInsets.only(right: _horizontalSpace),
    );
  }
}

class _BuildNavigation extends StatelessWidget {
  final double _horizontalSpace;
  final Size _deviceScreenSize;
  final int _activeNavigatorIndex;
  final ValueChanged<int> _setActiveNavigation;

  _BuildNavigation(
    this._horizontalSpace,
    this._deviceScreenSize,
    this._activeNavigatorIndex,
    this._setActiveNavigation,
  );

  @override
  Widget build(_) {
    final _items = _BuildNavigationItems(
      _deviceScreenSize,
      _activeNavigatorIndex,
      _setActiveNavigation,
    );

    return Padding(
      padding: EdgeInsets.only(right: _horizontalSpace),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[_items, _BuildLink(_deviceScreenSize)],
      ),
    );
  }
}

class _BuildNavigationItems extends StatelessWidget {
  final Size _deviceScreenSize;
  final int _activeNavigatorIndex;
  final ValueChanged<int> _setActiveNavigation;

  _BuildNavigationItems(
    this._deviceScreenSize,
    this._activeNavigatorIndex,
    this._setActiveNavigation,
  );

  @override
  Widget build(_) {
    final _items = Stack(
      children: <Widget>[
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: navigations.length,
          itemBuilder: (BuildContext context, _itemIndex) {
            final _item = navigations[_itemIndex];
            return _BuildNavigationItem(
              _item,
              _itemIndex,
              _deviceScreenSize,
              _activeNavigatorIndex,
              _setActiveNavigation,
            );
          },
        ),
        _BuildGradientOverlay(_deviceScreenSize),
      ],
    );

    return Container(
      width: _deviceScreenSize.width * 0.70,
      height: _deviceScreenSize.height * 0.04,
      child: _items,
    );
  }
}

class _BuildNavigationItem extends StatelessWidget {
  final Navigations _item;
  final int _itemIndex;
  final Size _deviceScreenSize;
  final int _activeNavigatorIndex;
  final ValueChanged<int> _setActiveNavigation;

  _BuildNavigationItem(
    this._item,
    this._itemIndex,
    this._deviceScreenSize,
    this._activeNavigatorIndex,
    this._setActiveNavigation,
  );

  @override
  Widget build(_) {
    print('* _BuildNavigationItem \n');
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        right: (_deviceScreenSize.width * 0.06),
      ),
      child: GestureDetector(
        child: Text(
          '${_item.name}',
          style: TextStyle(
            fontSize: (_deviceScreenSize.width * 0.05) -
                (_activeNavigatorIndex == _itemIndex ? 2 : 4),
            fontWeight: FontWeight.bold,
            color: _activeNavigatorIndex == _itemIndex
                ? BaseColors.darkBlack
                : BaseColors.lightBlack,
          ),
        ),
        onTap: () {
          if (_activeNavigatorIndex != _itemIndex) {
            _setActiveNavigation(_itemIndex);
          }
        },
      ),
    );
  }
}

class _BuildLink extends StatelessWidget {
  final Size _deviceScreenSize;

  _BuildLink(this._deviceScreenSize);

  @override
  Widget build(_) {
    final _style = TextStyle(
      fontSize: _deviceScreenSize.width * 0.04,
      fontWeight: FontWeight.bold,
      color: BaseColors.main,
    );

    return GestureDetector(
      child: Text('View all', style: _style),
      onTap: () {},
    );
  }
}

class _BuildGradientOverlay extends StatelessWidget {
  final Size _deviceScreenSize;

  _BuildGradientOverlay(this._deviceScreenSize);

  @override
  Widget build(_) {
    final _gradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        BaseColors.background.withOpacity(0.9),
        BaseColors.background.withOpacity(0.3),
      ],
    );

    final _decoration = BoxDecoration(
      color: BaseColors.favorite,
      gradient: _gradient,
    );

    return Container(
      margin: EdgeInsets.only(left: _deviceScreenSize.width * 0.60),
      width: _deviceScreenSize.width * 0.15,
      decoration: _decoration,
    );
  }
}

class _BuildUserGreeting extends StatelessWidget {
  final Size _deviceScreenSize;
  final double _horizontalSpace;

  _BuildUserGreeting(this._deviceScreenSize, this._horizontalSpace);

  @override
  Widget build(_) {
    return Padding(
      padding: EdgeInsets.only(right: _horizontalSpace),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _BuildGreeting(_deviceScreenSize),
          _BuildUserImage(_deviceScreenSize),
        ],
      ),
    );
  }
}

class _BuildGreeting extends StatelessWidget {
  final Size _deviceScreenSize;

  _BuildGreeting(this._deviceScreenSize);

  @override
  Widget build(_) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _BuildGreetingName(_deviceScreenSize),
        _BuildGreetingSubText(_deviceScreenSize),
      ],
    );
  }
}

class _BuildGreetingName extends StatelessWidget {
  final Size _deviceScreenSize;

  _BuildGreetingName(this._deviceScreenSize);

  @override
  Widget build(_) {
    final _style = TextStyle(
      color: BaseColors.main,
      fontSize: _deviceScreenSize.width * 0.08,
      fontWeight: FontWeight.w700,
    );

    return Text('Hi, Nancy', style: _style);
  }
}

class _BuildGreetingSubText extends StatelessWidget {
  final Size _deviceScreenSize;

  _BuildGreetingSubText(this._deviceScreenSize);

  @override
  Widget build(_) {
    final _style = TextStyle(
      color: BaseColors.textBlack,
      fontSize: _deviceScreenSize.width * 0.05,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: EdgeInsets.only(
        top: _deviceScreenSize.width * 0.01,
      ),
      child: Text('Find your next adventure', style: _style),
    );
  }
}

class _BuildUserImage extends StatelessWidget {
  final Size _deviceScreenSize;

  _BuildUserImage(this._deviceScreenSize);

  @override
  Widget build(_) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Image.asset(
        'assets/images/user/nancy.png',
        width: _deviceScreenSize.width * 0.13,
        height: _deviceScreenSize.width * 0.13,
      ),
    );
  }
}

class _BuildSearchBar extends StatelessWidget {
  final Size _deviceScreenSize;
  final double _horizontalSpace;
  final double _iconSize;

  _BuildSearchBar(
    this._deviceScreenSize,
    this._horizontalSpace,
    this._iconSize,
  );
  @override
  Widget build(_) {
    final _inputDecoration = InputDecoration(
      border: InputBorder.none,
      hintText: 'Find trips ...',
      hintStyle: TextStyle(
        color: BaseColors.lightBlack,
        fontSize: _deviceScreenSize.height * 0.02,
        height: 1.3,
      ),
      prefixIcon: Icon(
        Icons.search,
        color: BaseColors.main,
        size: _iconSize,
      ),
      suffixIcon: Icon(
        Icons.menu,
        size: _iconSize,
        color: BaseColors.textBlack,
      ),
    );

    final _textField = TextField(
      cursorColor: BaseColors.main,
      style: TextStyle(
        fontSize: _deviceScreenSize.height * 0.02,
        color: BaseColors.textBlack,
      ),
      decoration: _inputDecoration,
    );

    return Container(
      height: _deviceScreenSize.height * 0.07,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: _horizontalSpace),
      padding: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: BaseColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: _textField,
    );
  }
}

class _BuildDestinationCards extends StatelessWidget {
  final Size _deviceScreenSize;
  final List<Destinations> _destinations;
  final int _activeNavigatorIndex;

  _BuildDestinationCards(
    this._deviceScreenSize,
    this._destinations,
    this._activeNavigatorIndex,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: _deviceScreenSize.height * 0.32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          Destinations _destination = _destinations[index];
          if (_activeNavigatorIndex == 1) {
            _destination = upcomingDestinations[index];
          }
          if (_activeNavigatorIndex == 2) {
            _destination = popularDestinations[index];
          }
          return _BuildDestinationCard(_destination, _deviceScreenSize);
        },
        itemCount: destinations.length,
      ),
    );
  }
}

class _BuildDestinationCard extends StatelessWidget {
  final Size _deviceScreenSize;
  final Destinations _destination;

  _BuildDestinationCard(this._destination, this._deviceScreenSize);

  @override
  Widget build(_) {
    return LayoutBuilder(
      builder: (__, constraints) {
        final double _parentHeight = constraints.maxHeight;

        final BoxDecoration _decoration = BoxDecoration(
          color: BaseColors.white,
          borderRadius: BorderRadius.circular(15.0),
        );

        final _destinationCard = Container(
          width: _deviceScreenSize.width * 0.75,
          margin: EdgeInsets.only(right: _deviceScreenSize.width * 0.05),
          decoration: _decoration,
          child: Column(
            children: <Widget>[
              _BuildCardImageSection(_parentHeight, _destination),
              _BuildCardInfoSection(_parentHeight, _destination),
            ],
          ),
        );

        return _destinationCard;
      },
    );
  }
}

class _BuildCardImageSection extends StatelessWidget {
  final double _parentHeight;
  final Destinations _destination;

  _BuildCardImageSection(this._parentHeight, this._destination);

  @override
  Widget build(_) {
    return Container(
      height: _parentHeight * 0.55,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _BuildCardImage(_destination),
          _BuildCardFavoriteIcon(_destination, _parentHeight),
        ],
      ),
    );
  }
}

class _BuildCardImage extends StatelessWidget {
  final Destinations _destination;

  _BuildCardImage(this._destination);

  @override
  Widget build(_) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
      child: Image.asset(
        'assets/images/destinations/${_destination.image}',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _BuildCardFavoriteIcon extends StatelessWidget {
  final Destinations _destination;
  final double _parentHeight;

  _BuildCardFavoriteIcon(this._destination, this._parentHeight);

  @override
  Widget build(_) {
    final _favoriteIcon = Center(
      child: Icon(
        _destination.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: BaseColors.favorite,
        size: _parentHeight * 0.08,
      ),
    );

    final _favoriteIconBackground = Container(
      height: _parentHeight * 0.14,
      width: _parentHeight * 0.14,
      decoration: BoxDecoration(
        color: BaseColors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: _favoriteIcon,
    );

    return Positioned(
      top: _parentHeight * 0.03,
      right: _parentHeight * 0.03,
      child: _favoriteIconBackground,
    );
  }
}

class _BuildCardInfoSection extends StatelessWidget {
  final double _parentHeight;
  final Destinations _destination;

  _BuildCardInfoSection(this._parentHeight, this._destination);

  @override
  Widget build(_) {
    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(
          _parentHeight * 0.05,
          _parentHeight * 0.05,
          _parentHeight * 0.05,
          _parentHeight * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _BuildDestinationLocation(_parentHeight, _destination),
            _BuildDestinationName(_parentHeight, _destination),
            _BuildDestinationMoreInfo(_parentHeight, _destination),
          ],
        ),
      ),
    );
  }
}

class _BuildDestinationLocation extends StatelessWidget {
  final double _parentHeight;
  final Destinations _destination;

  _BuildDestinationLocation(this._parentHeight, this._destination);

  @override
  Widget build(_) {
    final TextStyle _textStyle = TextStyle(
      color: BaseColors.lightBlack,
      fontSize: _parentHeight * 0.05 + 1,
      fontWeight: FontWeight.w500,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.location_on,
          size: _parentHeight * 0.06,
          color: BaseColors.main,
        ),
        SizedBox(width: 3),
        Text('${_destination.location}', style: _textStyle),
      ],
    );
  }
}

class _BuildDestinationName extends StatelessWidget {
  final double _parentHeight;
  final Destinations _destination;

  _BuildDestinationName(this._parentHeight, this._destination);

  @override
  Widget build(_) {
    final TextStyle _style = TextStyle(
      color: BaseColors.textBlack,
      fontSize: _parentHeight * 0.09,
      fontWeight: FontWeight.w700,
    );

    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Text('${_destination.name}', style: _style),
    );
  }
}

class _BuildDestinationMoreInfo extends StatelessWidget {
  final double _parentHeight;
  final Destinations _destination;

  _BuildDestinationMoreInfo(this._parentHeight, this._destination);

  @override
  Widget build(_) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.people_outline,
          color: BaseColors.lightBlack,
          size: _parentHeight * 0.10,
        ),
        SizedBox(width: _parentHeight * 0.03),
        _BuildExplorers(_parentHeight, _destination),
        _BuildDepartureTime(_parentHeight, _destination),
      ],
    );
  }
}

class _BuildExplorers extends StatelessWidget {
  final Destinations _destination;
  final double _parentHeight;

  _BuildExplorers(this._parentHeight, this._destination);

  @override
  Widget build(_) {
    double _initialMargin = 0.0;
    double _marginToAdd = _parentHeight * 0.08;

    final List<Widget> explorers = [];
    final _explorersList = _destination.explorer.take(2);

    final BoxDecoration _decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        color: BaseColors.white,
        width: _parentHeight * 0.007,
      ),
    );

    for (var i = 0; i < _explorersList.length + 1; i++) {
      final explorer = Positioned(
        left: _initialMargin,
        child: Container(
          width: _parentHeight * 0.10,
          height: _parentHeight * 0.10,
          decoration: _decoration,
          child: _BuildExplorerAvatar(
            _destination.explorer,
            _explorersList.length,
            i,
            _parentHeight,
          ),
        ),
      );

      explorers.add(explorer);

      _initialMargin += _marginToAdd;
    }

    return Expanded(
      child: Container(
        height: _parentHeight * 0.10,
        child: Stack(
          children: explorers,
        ),
      ),
    );
  }
}

class _BuildExplorerAvatar extends StatelessWidget {
  final List<String> _explorers;
  final int _slicedExplorerLength;
  final int _index;
  final double _parentHeight;

  _BuildExplorerAvatar(
    this._explorers,
    this._slicedExplorerLength,
    this._index,
    this._parentHeight,
  );

  @override
  Widget build(__) {
    if (_index < _slicedExplorerLength) {
      return CircleAvatar(
        backgroundImage:
            AssetImage('assets/images/explorers/${_explorers[_index]}.jpg'),
      );
    }

    return CircleAvatar(
      child: Text(
        '+${_explorers.length - 2}',
        style: TextStyle(
          fontSize: _parentHeight * 0.04 + 1.5,
          fontWeight: FontWeight.bold,
          color: BaseColors.main,
        ),
      ),
      backgroundColor: BaseColors.mainLight,
    );
  }
}

class _BuildDepartureTime extends StatelessWidget {
  final double _parentHeight;
  final Destinations _destination;

  _BuildDepartureTime(this._parentHeight, this._destination);

  @override
  Widget build(_) {
    final _style = TextStyle(
      fontSize: _parentHeight * 0.04 + 2.2,
      fontWeight: FontWeight.bold,
      color: BaseColors.textBlack,
    );

    return Row(
      children: <Widget>[
        Icon(
          Icons.access_time,
          color: BaseColors.lightBlack,
          size: _parentHeight * 0.09,
        ),
        SizedBox(width: 5),
        Text('${_destination.when}', style: _style),
      ],
    );
  }
}
