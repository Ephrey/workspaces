import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/loading.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/welcome_carousel.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/local_storage.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:maket/utils/numbers.dart';

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  ViewState _welcomeViewState = ViewState.idle;

  void _isAlreadyLoggedIn() async {
    _setViewStateToBusy();

    final dynamic token = await LocalStorage.get(HttpHeadersKeys.xToken);

    (token != null && token != false)
        ? pushRoute(context: context, name: AppRoute.shoppingListsView)
        : _setViewStateToIdle();
  }

  void _setViewStateToIdle() {
    _setState(() => _welcomeViewState = ViewState.idle);
  }

  void _setViewStateToBusy() {
    _setState(() => _welcomeViewState = ViewState.busy);
  }

  void _setState(Function callback) => setState(callback);

  @override
  void initState() {
    _isAlreadyLoggedIn();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: (_welcomeViewState == ViewState.busy)
          ? Loading()
          : PaddingView(
              child: CenteredView(
                child: ScrollableView(child: _WelcomeViewBody()),
              ),
            ),
    );
  }
}

class _WelcomeViewBody extends StatelessWidget {
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
            buttonType: ButtonType.primary,
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
