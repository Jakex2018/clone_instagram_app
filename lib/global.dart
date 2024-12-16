import 'package:flutter/material.dart';
import 'package:front_end_instagram/main.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/history_provider.dart';
import 'package:front_end_instagram/providers/post_provider.dart';
import 'package:front_end_instagram/providers/profile_provider.dart';
import 'package:front_end_instagram/providers/reels_provider.dart';
import 'package:front_end_instagram/providers/select_option_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:front_end_instagram/providers/video_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppPages {
  static List<SingleChildWidget> allBlocProviders(BuildContext context) => [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SelectOptionProvider()),
        ChangeNotifierProvider(create: (_) => ReelsProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(
          create: (context) {
            final users =
                Provider.of<UserProvider>(context, listen: false).menu;
            return HistoryProvider(
                users: users); // Pasamos la lista de usuarios
          },
        ),
        ChangeNotifierProvider(
          create: (context) => VideoProvider(),
          child: MyApp(),
        ),
      ];
}
