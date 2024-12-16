import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_end_instagram/modules/auth/login/services/auth_services.dart';
import 'package:front_end_instagram/modules/auth/login/widget/login_form.dart';
import 'package:front_end_instagram/shared/button_one.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body:SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width * 9,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('asset/vector/ins_logo.svg'),
                  SizedBox(
                    height: 15,
                  ),
                  ButtonOne(
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
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100,
                        height: 2,
                        color: Colors.black26,
                      ),
                      Text('Or'),
                      Container(
                        width: 100,
                        height: 2,
                        color: Colors.black26,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LoginForm(
                    emailControlle: emailController,
                    passwordController: passwordController,
                    onTap: () {
                      AuthServices().login(
                          context, emailController.text, passwordController.text);
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
