import 'package:flutter/material.dart';
import 'package:front_end_instagram/global.dart';
import 'package:front_end_instagram/modules/splash/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppPages.allBlocProviders(context),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Instagram Clone',
          home: Material(child: SplashPage())),
    );
  }
}