import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/home/widget/list_card.dart';
import 'package:front_end_instagram/modules/profile/profile_page.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/reels_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class VideoInfoBottomLeft extends StatelessWidget {
  const VideoInfoBottomLeft({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final reelsProvider = Provider.of<ReelsProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final reels = reelsProvider.reels;

    // Comprobar si la lista 'reels' no está vacía y que el índice actual es válido
    if (reels.isEmpty ||
        reelsProvider.currentReelIndex < 0 ||
        reelsProvider.currentReelIndex >= reels.length) {
      return SizedBox
          .shrink(); // No mostrar nada si no hay reels o el índice es inválido
    }

    final currentReel = reels[reelsProvider.currentReelIndex];

    final userAuth = authProvider.currentUserId?.id;
    final userId = currentReel.userId;
    final isAuth = userAuth == userId;

    final userData = userProvider.getUserById(userId!);
    if (reels.isEmpty) {
      return SizedBox.shrink(); // No se muestra nada si no hay reels
    }

    return Positioned(
      bottom: 0,
      left: 10,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    userId: userId,
                  ),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListCard(
                  photoImg: userData!.photoUser,
                  radius: 20,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      userData.username,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.music_note_outlined,
                          color: Colors.white,
                          size: 12,
                        ),
                        Text(
                          'rend.dev - Krwona',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                !isAuth
                    ? Container(
                        width: 70,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Seguir',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ))
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
