import 'package:flutter/material.dart';

class CustomRoute {
  static final CustomRoute _route = CustomRoute._internal();

  factory CustomRoute() {
    return _route;
  }

  CustomRoute._internal();

  Future<dynamic> pushRemove({required BuildContext context, required page}) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
        (route) => false);
  }

  Future<dynamic> push({required BuildContext context, required page}) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }

  Future<dynamic> pushNamed(
      {required BuildContext context, required String routeName}) {
    return Navigator.pushNamed(context, routeName);
  }

  Future<dynamic> pushNameRemove(
      {required BuildContext context, required String newRouteName}) {
    return Navigator.pushNamedAndRemoveUntil(
        context, newRouteName, (route) => false);
  }

  Future<dynamic> pushReplacement(
      {required BuildContext context, required page}) {
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }
}
