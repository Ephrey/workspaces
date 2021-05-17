import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/wecome_carousel.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:maket/utils/numbers.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: PaddingView(
        child: CenteredView(
          child: ScrollableView(child: _WelcomeViewBody()),
        ),
      ),
    );
  }
}

class _WelcomeViewBody extends StatefulWidget {
  @override
  __WelcomeViewBodyState createState() => __WelcomeViewBodyState();
}

class __WelcomeViewBodyState extends State<_WelcomeViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WelcomeCarousel(),
        Separator(distanceAsPercent: Numbers.seven),
        _WelcomeViewActionButtons(),
      ],
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
            buttonType: ButtonType.secondary,
            text: 'Log In',
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
            buttonType: ButtonType.primary,
            text: 'Register',
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
