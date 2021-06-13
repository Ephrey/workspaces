import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/navigation/pop.dart';
import 'package:maket/utils/numbers.dart';

class AlertBeforeDelete extends StatelessWidget {
  final String subTitle;
  final Function onYesPressed;

  AlertBeforeDelete({this.subTitle, this.onYesPressed});

  @override
  Widget build(BuildContext context) {
    double _titleSize =
        (Numbers.size(context: context, percent: Numbers.three) + Numbers.two);

    double _subTitleSize =
        (Numbers.size(context: context, percent: Numbers.two) - Numbers.one);

    TextStyle _titleStyle = TextStyle(
      fontSize: _titleSize,
      fontWeight: FontWeight.w800,
      color: kTextSecondaryColor,
    );

    TextStyle _subTitleStyle =
        TextStyle(fontSize: _subTitleSize, height: kTextHeight);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Text(textStyle: _titleStyle),
        Separator(distanceAsPercent: Numbers.two),
        _Text(text: subTitle, textStyle: _subTitleStyle),
        Separator(distanceAsPercent: Numbers.five),
        _DeleteListActionButtons(onYesPressed: onYesPressed),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  _Text({this.text: 'Are you sure ?', this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle, textAlign: TextAlign.center);
  }
}

class _DeleteListActionButtons extends StatelessWidget {
  final Function onYesPressed;

  _DeleteListActionButtons({this.onYesPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.primary,
            status: Status.error,
            text: 'Yes. I know',
            contentPosition: Position.center,
            onPressed: onYesPressed,
          ),
        ),
        Separator(dimension: Dimension.width),
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.secondary,
            text: 'No. Cancel',
            contentPosition: Position.center,
            onPressed: () => pop(context: context),
          ),
        ),
      ],
    );
  }
}
