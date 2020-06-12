import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_destinations/constants/activities.dart';
import 'package:travel_destinations/constants/custom_colors.dart';
import 'package:travel_destinations/constants/navigation_items.dart';
import 'package:travel_destinations/models/destination_model.dart';
import 'package:travel_destinations/models/user_model.dart';
import 'package:travel_destinations/screens/destination_details.dart';
import 'package:travel_destinations/utils/custom_route_builder.dart';
import 'package:travel_destinations/widgets/departure_time.dart';
import 'package:travel_destinations/widgets/location_name.dart';
import 'package:travel_destinations/widgets/destination_name.dart';
import 'package:travel_destinations/widgets/explorer_leading_icon.dart';
import 'package:travel_destinations/widgets/explorer_profile.dart';
import 'package:travel_destinations/widgets/favorite_icon.dart';
import 'package:travel_destinations/widgets/location_icon.dart';

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

    final double _horizontalSpace = _deviceScreenSize.width * .05;
    final double _verticalSpace = _deviceScreenSize.height * .06;
    final double _iconSize = _deviceScreenSize.width * .08;

    final _uiBlocs = Column(
      children: <Widget>[
        _BuildUserGreeting(_deviceScreenSize, _horizontalSpace, users[0]),
        SizedBox(height: _deviceScreenSize.height * .030),
        _BuildSearchBar(_deviceScreenSize, _horizontalSpace, _iconSize),
        SizedBox(height: _deviceScreenSize.height * .030),
        _BuildActivities(_deviceScreenSize),
        SizedBox(height: _deviceScreenSize.height * .015),
        _BuildSeparator(_horizontalSpace),
        SizedBox(height: _deviceScreenSize.height * .025),
        _BuildNavigation(
          _horizontalSpace,
          _deviceScreenSize,
          _activeNavigatorIndex,
          _setActiveNavigation,
        ),
        SizedBox(height: _deviceScreenSize.height * .020),
        _BuildDestinationCards(
          _deviceScreenSize,
          destinations,
          _activeNavigatorIndex,
        ),
      ],
    );

    final _padding = EdgeInsets.only(
      left: _horizontalSpace,
      top: _verticalSpace,
      bottom: _verticalSpace,
    );

    return Scaffold(
      backgroundColor: BaseColors.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.topCenter,
          padding: _padding,
          child: _uiBlocs,
        ),
      ),
      bottomNavigationBar: _BottomNavigationBar(),
    );
  }
}

class _BuildUserGreeting extends StatelessWidget {
  final Size _deviceScreenSize;
  final double _horizontalSpace;
  final Users _user;

  _BuildUserGreeting(
    this._deviceScreenSize,
    this._horizontalSpace,
    this._user,
  );

  @override
  Widget build(_) {
    print('Hello, from user info :)');
    final _greeting = <Widget>[
      _BuildGreeting(_deviceScreenSize, _user),
      _BuildUserImage(_deviceScreenSize, _user),
    ];

    return Padding(
      padding: EdgeInsets.only(right: _horizontalSpace),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _greeting,
      ),
    );
  }
}

class _BuildGreeting extends StatelessWidget {
  final Size _deviceScreenSize;
  final Users _user;

  _BuildGreeting(this._deviceScreenSize, this._user);

  @override
  Widget build(_) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _BuildGreetingName(_deviceScreenSize, _user),
        _BuildGreetingSubText(_deviceScreenSize),
      ],
    );
  }
}

class _BuildGreetingName extends StatelessWidget {
  final Size _deviceScreenSize;
  final Users _user;

  _BuildGreetingName(this._deviceScreenSize, this._user);

  @override
  Widget build(_) {
    final _style = TextStyle(
      color: BaseColors.main,
      fontSize: _deviceScreenSize.width * .08,
      fontWeight: FontWeight.w700,
    );

    return Text('Hi, ${_user.name}', style: _style);
  }
}

class _BuildGreetingSubText extends StatelessWidget {
  final Size _deviceScreenSize;

  _BuildGreetingSubText(this._deviceScreenSize);

  @override
  Widget build(_) {
    final _style = TextStyle(
      color: BaseColors.textBlack,
      fontSize: _deviceScreenSize.width * .05,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: EdgeInsets.only(top: _deviceScreenSize.width * .01),
      child: Text('Find your next adventure', style: _style),
    );
  }
}

class _BuildUserImage extends StatelessWidget {
  final Size _deviceScreenSize;
  final Users _user;

  _BuildUserImage(this._deviceScreenSize, this._user);

  @override
  Widget build(_) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Image.asset(
        'assets/images/user/${_user.profile}',
        width: _deviceScreenSize.width * .13,
        height: _deviceScreenSize.width * .13,
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
      hintStyle: TextStyle(color: BaseColors.lightBlack),
      prefixIcon: Icon(Icons.search, color: BaseColors.main, size: _iconSize),
      suffixIcon: Icon(
        Icons.menu,
        size: _iconSize,
        color: BaseColors.textBlack,
      ),
    );

    final _textField = TextField(
      cursorColor: BaseColors.main,
      style: TextStyle(
        color: BaseColors.textBlack,
      ),
      decoration: _inputDecoration,
    );

    return Container(
      height: _deviceScreenSize.height * .07,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: _horizontalSpace),
      decoration: BoxDecoration(
        color: BaseColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: _textField,
    );
  }
}

class _BuildActivities extends StatelessWidget {
  final Size _deviceScreenSize;

  _BuildActivities(this._deviceScreenSize);

  @override
  Widget build(_) {
    final _activities = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: activities.length,
      itemBuilder: (_, i) {
        return _BuildActivity(activities[i], _deviceScreenSize);
      },
    );

    return Container(
      height: _deviceScreenSize.height * .19,
      child: _activities,
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
      width: _deviceScreenSize.width * .32,
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
      borderRadius: BorderRadius.circular(20.0),
    );

    final _icon = Center(
      child: Icon(
        _activity.icon,
        size: _parentHeight * .28,
        color: BaseColors.main,
      ),
    );

    return Container(
      decoration: _decoration,
      height: _parentHeight * .78,
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
      fontSize: _parentHeight * .10,
      fontWeight: FontWeight.w700,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: _parentHeight * .02),
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
      margin: EdgeInsets.only(top: 10.0, right: _horizontalSpace),
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
    final _itemsList = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: navigations.length,
      itemBuilder: (_, _itemIndex) {
        final _item = navigations[_itemIndex];
        return _BuildNavigationItem(
          _item,
          _itemIndex,
          _deviceScreenSize,
          _activeNavigatorIndex,
          _setActiveNavigation,
        );
      },
    );

    final _items = Stack(
      children: <Widget>[
        _itemsList,
        _BuildGradientOverlay(_deviceScreenSize),
      ],
    );

    return Container(
      width: _deviceScreenSize.width * .70,
      height: _deviceScreenSize.height * .04,
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

  void _activeNavigation() {
    if (_activeNavigatorIndex != _itemIndex) {
      _setActiveNavigation(_itemIndex);
    }
  }

  @override
  Widget build(_) {
    final _itemColor = _activeNavigatorIndex == _itemIndex
        ? BaseColors.darkBlack
        : BaseColors.lightBlack;

    final _itemFontSize = (_deviceScreenSize.width * .05) -
        (_activeNavigatorIndex == _itemIndex ? 2.0 : 4.0);

    final _style = TextStyle(
      fontSize: _itemFontSize,
      fontWeight: FontWeight.bold,
      color: _itemColor,
    );

    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: _deviceScreenSize.width * .06),
      child: GestureDetector(
        child: Text('${_item.name}', style: _style),
        onTap: () => _activeNavigation(),
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
      fontSize: _deviceScreenSize.width * .04,
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
        BaseColors.background.withOpacity(.9),
        BaseColors.background.withOpacity(.3),
      ],
    );

    final _decoration = BoxDecoration(
      color: BaseColors.favorite,
      gradient: _gradient,
    );

    return Container(
      margin: EdgeInsets.only(left: _deviceScreenSize.width * .60),
      width: _deviceScreenSize.width * .15,
      decoration: _decoration,
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
      height: _deviceScreenSize.height * .32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          Destinations _destination = _destinations[index];
          if (_activeNavigatorIndex == 1.0) {
            _destination = upcomingDestinations[index];
          }
          if (_activeNavigatorIndex == 2.0) {
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
    return GestureDetector(
      child: LayoutBuilder(
        builder: (__, constraints) {
          final double _parentHeight = constraints.maxHeight;

          final BoxDecoration _decoration = BoxDecoration(
            color: BaseColors.white,
            borderRadius: BorderRadius.circular(15.0),
          );

          final _destinationCard = Container(
            width: _deviceScreenSize.width * .75,
            margin: EdgeInsets.only(right: _deviceScreenSize.width * .05),
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
      ),
      onTap: () => Navigator.push(
        _,
        buildCustomRoute(DestinationDetails(destination: _destination)),
      ),
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
      height: _parentHeight * .55,
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

  void _onIconTape(bool value) {
    print(value);
  }

  @override
  Widget build(_) {
    return Positioned(
      top: _parentHeight * .03,
      right: _parentHeight * .03,
      child: FavoriteIcon(
        iconSize: _parentHeight * .08,
        iconContainerSize: _parentHeight * .14,
        isFavorite: _destination.isFavorite,
        onIconTapped: _onIconTape,
      ),
    );
  }
}

class _BuildCardInfoSection extends StatelessWidget {
  final double _parentHeight;
  final Destinations _destination;

  _BuildCardInfoSection(this._parentHeight, this._destination);

  @override
  Widget build(_) {
    final _padding = EdgeInsets.fromLTRB(
      _parentHeight * .05,
      _parentHeight * .05,
      _parentHeight * .05,
      _parentHeight * .01,
    );

    final _cardInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _BuildLocationName(_parentHeight, _destination),
        _BuildDestinationName(_parentHeight, _destination),
        _BuildDestinationMoreInfo(_parentHeight, _destination),
      ],
    );

    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.topLeft,
        padding: _padding,
        child: _cardInfo,
      ),
    );
  }
}

class _BuildLocationName extends StatelessWidget {
  final double _parentHeight;
  final Destinations _destination;

  _BuildLocationName(this._parentHeight, this._destination);

  @override
  Widget build(_) {
    final String _locationName = _destination.location;
    final double _fontSize = _parentHeight * .05 + 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        LocationIcon(iconSize: _parentHeight * .06),
        SizedBox(width: 3.0),
        LocationName(name: _locationName, fontSize: _fontSize),
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
    final String _name = _destination.name;

    return Padding(
      padding: EdgeInsets.only(
        top: _parentHeight * .03,
        bottom: _parentHeight * .05,
      ),
      child: DestinationName(name: _name, size: _parentHeight * .09),
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
        LeadingIcon(size: _parentHeight * 0.10),
        SizedBox(width: _parentHeight * 0.03),
        ExplorerProfile(
          destination: _destination,
          nocheSize: _parentHeight * 0.08,
          borderSize: _parentHeight * 0.007,
          profileSize: _parentHeight * 0.10,
          profileContainerHeight: _parentHeight * 0.10,
          moreUserTextSize: _parentHeight * 0.04 + 1.5,
        ),
        DepartureTime(
          time: _destination.when,
          fontSize: _parentHeight * 0.04 + 2.2,
          iconSize: _parentHeight * 0.09,
        ),
      ],
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(_) {
    final _navItemsStyle = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    );

    return BottomNavigationBar(
      backgroundColor: BaseColors.white,
      iconSize: 30.0,
      currentIndex: 0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home', style: _navItemsStyle),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          title: Text('Explorer', style: _navItemsStyle),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('Profile', style: _navItemsStyle),
        ),
      ],
      selectedItemColor: BaseColors.main,
      selectedLabelStyle: _navItemsStyle,
      unselectedItemColor: BaseColors.lightBlack,
    );
  }
}
