import 'dart:io';

import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/auth/login/login_page.dart';
import 'package:front_end_instagram/modules/auth/login/services/auth_services.dart';
import 'package:front_end_instagram/modules/auth/login/widget/text_input.dart';
import 'package:front_end_instagram/modules/auth/register/widget/choose_image.dart';
import 'package:front_end_instagram/shared/button_one.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm(
      {super.key,
      this.onTap,
      required this.usernameController,
      required this.emailController,
      required this.passwordController,
      required this.confirmController});
  final Function()? onTap;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmController;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  File? file;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextInput(
            title: 'username',
            controller: widget.usernameController,
          ),
          SizedBox(
            height: 12,
          ),
          TextInput(
            controller: widget.emailController,
            title: 'email',
          ),
          SizedBox(
            height: 12,
          ),
          TextInput(
            controller: widget.passwordController,
            title: 'password',
          ),
          SizedBox(
            height: 12,
          ),
          TextInput(
            controller: widget.confirmController,
            title: 'confirm password',
          ),
          SizedBox(
            height: 30,
          ),
          ChooseImage(
            onImageSelected: (selectFile) {
              setState(() {
                file = selectFile;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          ButtonOne(
            radius: 10,
            widget: Center(
              child: Text(
                'Log In',
                style: TextStyle(color: Colors.white),
              ),
            ),
            height: 40,
            onTap: () {
              AuthServices().register(
                  context,
                  widget.usernameController.text,
                  widget.emailController.text,
                  widget.passwordController.text,
                  widget.confirmController.text,
                  file);
            },
            color: Color(0xFF1877F2).withOpacity(.5),
            width: MediaQuery.of(context).size.width * .8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('you already have an account?'),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                  child: Text(
                    'sign in',
                    style: TextStyle(
                      color: Color(0xFF1877F2),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
