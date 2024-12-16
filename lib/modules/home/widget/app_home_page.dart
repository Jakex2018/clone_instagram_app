import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/history_model.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/modules/home/widget/app_home_menu.dart';
import 'package:front_end_instagram/modules/home/widget/list_card.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/history_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:front_end_instagram/providers/video_provider.dart';
import 'package:front_end_instagram/shared/history_screen.dart';
import 'package:provider/provider.dart';

class AppHomePage extends StatelessWidget {
  const AppHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);
    final menuUser = Provider.of<UserProvider>(context).menu;
    final sizeW = MediaQuery.of(context).size.width;

    List<UserModel> filteredMenu = _filterAndSortUsers(user, menuUser);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: sizeW,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppPageMenu(),
          SizedBox(height: 0),
          _buildUserListView(filteredMenu, context),
        ],
      ),
    );
  }

  List<UserModel> _filterAndSortUsers(
      AuthProvider user, List<UserModel> menuUser) {
    List<UserModel> orderedMenu = List.from(menuUser);
    List<UserModel> filteredMenu = orderedMenu.where((element) {
      return element.id == user.currentUserId?.id ||
          user.currentUserId?.following.contains(element.id) == true;
    }).toList();

    // Ordenar para poner el usuario actual primero
    filteredMenu.sort((a, b) {
      if (a.id == user.currentUserId?.id) return -1;
      if (b.id == user.currentUserId?.id) return 1;
      return 0;
    });

    return filteredMenu;
  }

  Widget _buildUserListView(List<UserModel> filteredMenu, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .16,
        child: Consumer<VideoProvider>(
          builder: (context, videoProvider, child) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: filteredMenu.length,
              itemBuilder: (context, index) {
                final menuUser = filteredMenu[index];
                return _buildUserCard(menuUser, context);
              },
              separatorBuilder: (context, index) => SizedBox(width: 10),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserCard(UserModel menuUser, context) {
    return GestureDetector(
      onTap: () => _onUserTap(menuUser, context),
      child: ListCard(
        name: menuUser.username,
        photoImg: menuUser.photoUser,
      ),
    );
  }

  void _onUserTap(UserModel menuUser, context) {
    final historyProvider =
        Provider.of<HistoryProvider>(context, listen: false);
    final stories = historyProvider.getStoriesForUser(menuUser.id);

    if (stories.isEmpty) {
      _showNoStoriesMessage(context);
    } else {
      _navigateToHistoryScreen(stories, context);
    }
  }

  void _navigateToHistoryScreen(List<Storymodel> stories, context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(stories: stories),
      ),
    );
  }

  void _showNoStoriesMessage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Text(
              'No hay historias disponibles',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}







/*
class AppHomePage extends StatelessWidget {
  const AppHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);
    final menuUser = Provider.of<UserProvider>(context).menu;
    final sizeW = MediaQuery.of(context).size.width;

    // Filtrar usuarios que el usuario sigue, o el mismo usuario.
    List<UserModel> orderedMenu = List.from(menuUser);
    List<UserModel> filteredMenu = orderedMenu.where((element) {
      return element.id == user.currentUserId?.id ||
          user.currentUserId?.following.contains(element.id) == true;
    }).toList();

    filteredMenu.sort((a, b) {
      if (a.id == user.currentUserId?.id) return -1;
      if (b.id == user.currentUserId?.id) return 1;
      return 0;
    });

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: sizeW,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppPageMenu(),
          SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .16,
              child: Consumer<VideoProvider>(
                builder: (context, videoProvider, child) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final menuUser = filteredMenu[index];
                      String photoImg = menuUser.photoUser;
                      String name = menuUser.username;

                      return GestureDetector(
                        onTap: () {
                          final historyProvider = Provider.of<HistoryProvider>(
                              context,
                              listen: false);

                          // Obtener las historias del usuario que fue tocado
                          final stories =
                              historyProvider.getStoriesForUser(menuUser.id);

                          if (stories.isEmpty) {
                            // Si no hay historias, mostrar mensaje
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Scaffold(
                                  backgroundColor: Colors.black,
                                  body: Center(
                                    child: Text(
                                      'No hay historias disponibles',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            // Si hay historias, redirigir al HistoryScreen con la primera historia

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryScreen(
                                  stories: stories, // Pasamos las historias
                                ),
                              ),
                            );
                          }
                        },
                        child: ListCard(
                          name: name,
                          photoImg: photoImg,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    itemCount: filteredMenu.length,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


 */