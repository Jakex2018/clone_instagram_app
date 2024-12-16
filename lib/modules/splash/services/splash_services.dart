// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/application/application_page.dart';
import 'package:front_end_instagram/modules/auth/login/login_page.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashServices {
  Future<void> redirect(BuildContext context, Widget widget) async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  Future<void> checkAuth(BuildContext context) async {
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    if (!authProvider.isLoggedIn) {
      redirect(context, const LoginPage());
    } else {
      redirect(context, const ApplicationPage());
    }
  }
}
