import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/widgets/buttons/circle_button.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class SocialNetworkIcons extends StatelessWidget {
  final Separator _separator = Separator(
    dimension: Dimension.width,
    distanceAsPercent: Numbers.ten,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleButton(
          icon: FontAwesomeIcons.google,
          onTap: () => print('Login with google'),
        ),
        _separator,
        CircleButton(
          icon: FontAwesomeIcons.twitter,
          onTap: () => print('Login with twitter'),
        ),
        _separator,
        CircleButton(
          icon: FontAwesomeIcons.facebook,
          onTap: () => print('Login with facebook'),
        ),
      ],
    );
  }
}
