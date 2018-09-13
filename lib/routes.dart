import 'package:flutter/material.dart';
import 'pages/loginPage.dart';
import 'pages/registerPage.dart';
import 'pages/mainTabsPage.dart';
import 'pages/forgotPasswordPage.dart';

Map<String, WidgetBuilder> buildAppRoutes() {
  return {
    '/login': (BuildContext context) => new LoginPage(),
    '/register': (BuildContext context) => new RegisterPage(),
    '/forgotpassword': (BuildContext context) => new ForgotPasswordPage(),
    '/maintabs': (BuildContext context) => MainTabsPage(),
  };
}
