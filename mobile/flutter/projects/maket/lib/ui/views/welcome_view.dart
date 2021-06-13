import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/constants/welcome_text.dart';
import 'package:maket/ui/views/base/aligned_view.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/views/base/stacked_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/loading.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/local_storage.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:maket/utils/numbers.dart';

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  ViewState _welcomeViewState = ViewState.busy;

  void _isAlreadyLoggedIn() async {
    (await LocalStorage.get(HttpHeadersKeys.xToken) != null)
        ? pushRoute(context: context, name: AppRoute.shoppingListsView)
        : setState(() => _welcomeViewState = ViewState.idle);
  }

  @override
  void initState() {
    _isAlreadyLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final StackedView _body = StackedView(
      children: [
        AlignedView(
          child: ScrollableView(child: _WelcomeViewBody()),
          position: Alignment.center,
        ),
        AlignedView(
          child: _WelcomeViewActionButtons(),
          position: Alignment.bottomCenter,
        ),
      ],
    );
    return BaseView(
      backgroundColor: kPrimaryColor,
      child: (_welcomeViewState == ViewState.busy)
          ? Loading()
          : PaddingView(child: _body),
    );
  }
}

class _WelcomeViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          kAppName,
          style: TextStyle(
            fontSize: (Numbers.size(context: context, percent: Numbers.five)),
            fontWeight: FontWeight.w800,
            color: kTextPrimaryColor,
          ),
        ),
        Text(
          kAppSlogan,
          style: TextStyle(
            fontSize: (Numbers.size(context: context, percent: Numbers.three) +
                Numbers.three),
            color: kTextSecondaryColor,
          ),
        ),
        Separator(distanceAsPercent: Numbers.five),
        _AppFeature(),
        Separator(distanceAsPercent: Numbers.six),
      ],
    );
  }
}

class _AppFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> _buildAppFeature() {
      List<Widget> _features = [];

      for (AppFeature feature in appFeatures) {
        _features.add(_FeaturesBlock(feature: feature));
        _features.add(Separator(distanceAsPercent: Numbers.three));
      }
      return _features;
    }

    return Column(children: _buildAppFeature());
  }
}

class _FeaturesBlock extends StatelessWidget {
  final AppFeature feature;

  _FeaturesBlock({this.feature});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _Icon(icon: feature.icon, color: feature.color),
        Separator(dimension: Dimension.width, distanceAsPercent: Numbers.five),
        _TitleAndSubTitle(feature: feature),
      ],
    );
  }
}

class _Icon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _Icon({this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    final double size = (Numbers.size(context: context, percent: Numbers.four));
    return Icon(icon, size: size, color: color);
  }
}

class _TitleAndSubTitle extends StatelessWidget {
  final AppFeature feature;

  const _TitleAndSubTitle({this.feature});

  @override
  Widget build(BuildContext context) {
    final double _fontSize =
        (Numbers.size(context: context, percent: Numbers.two));

    EdgeInsets _padding = EdgeInsets.only(
      right: (Numbers.size(context: context, percent: Numbers.five) +
          Numbers.four),
    );

    final Text _title = Text(
      feature.title,
      style: TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.w900,
        color: kTextPrimaryColor,
      ),
    );

    final Text _subTitle = Text(
      feature.subtitle,
      style: TextStyle(
        fontSize: _fontSize,
        height: 1.5,
        color: kTextSecondaryColor,
      ),
    );

    final Column _features = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title,
        Separator(distanceAsPercent: Numbers.four, thin: true),
        _subTitle,
      ],
    );

    return ExpandedView(
      child: PaddingView(padding: _padding, child: _features),
    );
  }
}

class _WelcomeViewActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.primary,
            text: kTextButtonLogin,
            contentPosition: Position.center,
            onPressed: () => pushRoute(
              context: context,
              name: AppRoute.signInView,
            ),
          ),
        ),
        Separator(dimension: Dimension.width),
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.secondary,
            text: kTextButtonRegister,
            contentPosition: Position.center,
            onPressed: () => pushRoute(
              context: context,
              name: AppRoute.registerView,
            ),
          ),
        ),
      ],
    );
  }
}
