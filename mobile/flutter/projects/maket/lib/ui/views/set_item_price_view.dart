import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/main_title.dart';
import 'package:maket/ui/widgets/model_container.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class SetItemPriceView extends StatelessWidget {
  final dynamic item;

  SetItemPriceView({this.item});

  @override
  Widget build(BuildContext context) {
    return ModalContainer(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MainTitle(text: 'Set ${item['name']} Price'),
          Separator(distanceAsPercent: Numbers.four),
          FormInput(
            hintText: 'Type in the ${item['name']} price',
            textAlign: TextAlign.center,
          ),
          Separator(distanceAsPercent: Numbers.three),
          ActionButton(
            text: 'Done',
            contentPosition: Position.center,
            onPressed: () => print('Setting ${item['name']} price ...'),
          )
        ],
      ),
    );
  }
}
