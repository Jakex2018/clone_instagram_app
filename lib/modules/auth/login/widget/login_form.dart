import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/auth/login/widget/text_input.dart';
import 'package:front_end_instagram/modules/auth/register/register_page.dart';
import 'package:front_end_instagram/shared/button_one.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, this.onTap, required this.passwordController, required this.emailControlle});
  final Function()? onTap;
  final TextEditingController passwordController;
  final TextEditingController emailControlle;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextInput(
            controller: widget.emailControlle,
            title: 'email',
          ),
          SizedBox(
            height: 12,
          ),
          TextInput(
            controller: widget.passwordController,
            title: 'password',
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  color: Color(0xFF1877F2),
                ),
              )),
          SizedBox(
            height: 15,
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
            onTap: widget.onTap,
            color: Color(0xFF1877F2).withOpacity(.5),
            width: MediaQuery.of(context).size.width * .8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dont have an account'),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ));
                  },
                  child: Text(
                    'sign up',
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
