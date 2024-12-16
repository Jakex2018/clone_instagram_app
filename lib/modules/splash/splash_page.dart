// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_end_instagram/modules/application/application_page.dart';
import 'package:front_end_instagram/modules/auth/login/login_page.dart';
import 'package:front_end_instagram/modules/splash/services/splash_services.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final services = SplashServices();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return _buildSplash();
        }
        _navigateBasedOnAuthStatus(authProvider);
        return _buildSplash();
      },
    );
  }

  Widget _buildSplash() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          splashLogo(),
          SizedBox(
            height: 270,
          ),
          splashText(),
        ],
      ),
    );
  }

  Column splashText() {
    return Column(
      children: [
        Text(
          'from',
          style: TextStyle(
              color: const Color.fromARGB(255, 173, 172, 172),
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [Colors.orange, Colors.pink],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'asset/vector/meta-logo-facebook.svg',
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      height: 30,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Meta',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget splashLogo() {
    return SvgPicture.asset(
      'asset/vector/instagram.svg',
      height: 120,
    );
  }

  void _navigateBasedOnAuthStatus(AuthProvider authProvider) {
    if (authProvider.isLoggedIn) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ApplicationPage()));
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
  }
}
