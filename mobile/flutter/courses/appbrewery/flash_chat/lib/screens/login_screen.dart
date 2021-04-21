import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/utils/routes.dart';
import 'package:flash_chat/widget/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String email;
  String password;

  bool _showLoading = false;

  void _toggleLoading(bool status) {
    setState(() {
      _showLoading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'flash_logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
                onChanged: (value) {
                  email = value.trim();
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  _toggleLoading(true);
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (user != null) {
                      _toggleLoading(false);
                      Navigator.of(context).pushNamed(Routes.chat);
                    }
                  } catch (e) {
                    _toggleLoading(false);
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
        inAsyncCall: _showLoading,
      ),
    );
  }
}
