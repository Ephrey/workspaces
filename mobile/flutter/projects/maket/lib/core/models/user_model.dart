import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String password;

  User({
    @required this.name,
    @required this.email,
    @required this.password,
  })  : assert(name != null),
        assert(email != null),
        assert(password != null);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, String> toJson() {
    return {
      'name': this.name,
      'email': this.email,
      'password': this.password,
    };
  }
}

class UserLogin {
  final String email;
  final String password;

  UserLogin({@required this.email, @required this.password})
      : assert(email != null),
        assert(password != null);

  factory UserLogin.fromJson(Map<String, String> json) {
    return UserLogin(email: json['email'], password: json['password']);
  }

  Map<String, String> toJson() {
    return {
      'email': this.email,
      'password': this.password,
    };
  }
}
