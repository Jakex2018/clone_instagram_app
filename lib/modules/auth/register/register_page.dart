import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_end_instagram/modules/auth/register/widget/register_form.dart';
import 'package:front_end_instagram/shared/auth_or.dart';
import 'package:front_end_instagram/shared/button_one.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController pathController = TextEditingController();
  File? file;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          width: MediaQuery.of(context).size.width * 9,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              registerImage(),
              SizedBox(
                height: 15,
              ),
              buttonRegister(context),
              SizedBox(
                height: 50,
              ),
              AuthOr(),
              SizedBox(
                height: 20,
              ),
              RegisterForm(
                confirmController: confirmController,
                emailController: emailController,
                passwordController: passwordController,
                usernameController: usernameController,
              ),
            ],
          )),
    );
  }

  SvgPicture registerImage() => SvgPicture.asset('asset/vector/ins_logo.svg');

  ButtonOne buttonRegister(BuildContext context) {
    return ButtonOne(
      radius: 10,
      widget: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.facebook_outlined,
            color: Colors.white,
          ),
          Text(
            'Continue with Facebook',
            style: TextStyle(color: Colors.white),
          ),
        ],
      )),
      height: 40,
      color: Color(0xFF1877F2),
      width: MediaQuery.of(context).size.width * .8,
    );
  }
}


/*
onTap: () {
                  AuthServices().register(
                      context,
                      usernameController.text,
                      emailController.text,
                      passwordController.text,
                      confirmController.text);
                },
 */