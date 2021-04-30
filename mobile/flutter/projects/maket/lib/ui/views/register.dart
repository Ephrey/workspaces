import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/texts/rich_text.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: PaddingView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.arrow_back,
                size: Math.percentage(
                  percent: Numbers.fore,
                  total: ScreenSize(context: context).height,
                ),
              ),
              height: Math.percentage(
                percent: Numbers.seven,
                total: ScreenSize(context: context).height,
              ),
            ),
            Expanded(
              flex: 2,
              child: CenteredView(
                child: ScrollableView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormInput(label: 'Name'),
                        Separator(distanceAsPercent: Numbers.three),
                        FormInput(
                          label: 'Email',
                          keyBorderType: TextInputType.emailAddress,
                        ),
                        Separator(distanceAsPercent: Numbers.three),
                        FormInput(label: 'Password', password: true),
                        Separator(),
                        ActionButton(
                          buttonType: ButtonType.disable,
                          text: 'Create',
                          onPressed: () => print('creating account ... '),
                          contentPosition: Position.center,
                        ),
                        Separator(),
                        CenteredView(
                          child: TextRich(
                            mainText: 'Have an account',
                            richText: 'Sign In',
                            onTap: () => print('Navigate to sign in view ...'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
