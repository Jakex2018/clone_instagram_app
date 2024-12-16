import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:front_end_instagram/shared/build_button_follow.dart';
import 'package:front_end_instagram/shared/build_button_unfollow.dart';
import 'package:front_end_instagram/shared/button_one.dart';
import 'package:provider/provider.dart';

class ProfileOptions extends StatefulWidget {
  const ProfileOptions({
    super.key,
    this.user,
  });
  final UserModel? user;

  @override
  State<ProfileOptions> createState() => _ProfileOptionsState();
}

class _ProfileOptionsState extends State<ProfileOptions> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.loadFollowingStatus();
    userProvider.loadUserData(widget.user!.id);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final currentUser = authProvider.currentUserId;

    if (currentUser == null) {
      return Center(child: Text('Por favor, inicia sesión.'));
    }

    final isProfileAuth = currentUser.id == widget.user?.id;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: isProfileAuth
            ? _buildAuthOption(authProvider, userProvider, currentUser, context)
            : _buildOtherOption(
                authProvider, widget.user, userProvider, currentUser, context));
  }

  Row _buildAuthOption(AuthProvider authProvider, UserProvider userProvider,
      UserModel? currentUser, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ButtonOne(
          onTap: () {},
          widget: Center(
              child: Text(
            'Compartir',
            style: TextStyle(color: Colors.white),
          )),
          height: MediaQuery.of(context).size.height * .048,
          width: MediaQuery.of(context).size.width * .30,
          color: const Color.fromARGB(255, 101, 100, 100),
          radius: 10,
        ),
        SizedBox(
          width: 10,
        ),
        ButtonOne(
          widget: Center(
              child: Text(
            'Editar Perfil',
            style: TextStyle(color: Colors.white),
          )),
          height: MediaQuery.of(context).size.height * .048,
          width: MediaQuery.of(context).size.width * .35,
          color: const Color.fromARGB(255, 101, 100, 100),
          radius: 10,
        ),
        SizedBox(
          width: 10,
        ),
        ButtonOne(
          widget: Icon(
            Icons.person_add_rounded,
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height * .048,
          width: MediaQuery.of(context).size.width * .1,
          color: const Color.fromARGB(255, 101, 100, 100),
          radius: 10,
        ),
      ],
    );
  }

  _buildOtherOption(AuthProvider authProvider, UserModel? user,
      UserProvider userProvider, UserModel currentUser, BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      userProvider.isFollowing
          ? BuildButtonUnfollow(
              userProvider: userProvider,
              user: user,
              currentUser: currentUser,
              context: context)
          : BuildButtonFollow(
              userProvider: userProvider,
              user: user,
              currentUser: currentUser,
              context: context),
      SizedBox(
        width: 10,
      ),
      ButtonOne(
        widget: Center(
            child: Text(
          'Enviar Mensaje',
          style: TextStyle(color: Colors.white),
        )),
        height: MediaQuery.of(context).size.height * .048,
        width: MediaQuery.of(context).size.width * .35,
        color: const Color.fromARGB(255, 101, 100, 100),
        radius: 10,
      ),
      SizedBox(
        width: 10,
      ),
      ButtonOne(
        widget: Icon(
          Icons.person_add_rounded,
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height * .048,
        width: MediaQuery.of(context).size.width * .1,
        color: const Color.fromARGB(255, 101, 100, 100),
        radius: 10,
      ),
    ]);
  }
}







/*
import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:front_end_instagram/shared/button_one.dart';
import 'package:provider/provider.dart';

class ProfileOptions extends StatefulWidget {
  const ProfileOptions({
    super.key,
    this.user,
  });
  final UserModel? user;

  @override
  State<ProfileOptions> createState() => _ProfileOptionsState();
}

class _ProfileOptionsState extends State<ProfileOptions> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    final currentUser = authProvider.currentUserId;

    if (currentUser == null) {
      return Center(child: Text('Por favor, inicia sesión.'));
    }

    final isProfileAuth = currentUser.id == widget.user?.id;

    bool isFollowing = currentUser.following.contains(widget.user!.id);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: isProfileAuth
            ? _buildAuthOption(
                isFollowing, authProvider, userProvider, currentUser, context)
            : _buildOtherOption(isFollowing, authProvider, widget.user,
                userProvider, currentUser, context));
  }

  Row _buildAuthOption(bool isFollowing, AuthProvider authProvider,
      UserProvider userProvider, UserModel? currentUser, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ButtonOne(
          onTap: () {},
          widget: Center(
              child: Text(
            'Compartir',
            style: TextStyle(color: Colors.white),
          )),
          height: MediaQuery.of(context).size.height * .048,
          width: MediaQuery.of(context).size.width * .30,
          color: const Color.fromARGB(255, 101, 100, 100),
          radius: 10,
        ),
        SizedBox(
          width: 10,
        ),
        ButtonOne(
          widget: Center(
              child: Text(
            'Editar Perfil',
            style: TextStyle(color: Colors.white),
          )),
          height: MediaQuery.of(context).size.height * .048,
          width: MediaQuery.of(context).size.width * .35,
          color: const Color.fromARGB(255, 101, 100, 100),
          radius: 10,
        ),
        SizedBox(
          width: 10,
        ),
        ButtonOne(
          widget: Icon(
            Icons.person_add_rounded,
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height * .048,
          width: MediaQuery.of(context).size.width * .1,
          color: const Color.fromARGB(255, 101, 100, 100),
          radius: 10,
        ),
      ],
    );
  }

  Row _buildOtherOption(
      bool isFollowing,
      AuthProvider authProvider,
      UserModel? user,
      UserProvider userProvider,
      UserModel? currentUser,
      BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Consumer<UserProvider>(builder: (context, userProvider, child) {
          return isFollowing
              ? _buidButtonUnfollow(
                  isFollowing, authProvider, userProvider, currentUser, context)
              : _buildButtonFollow(isFollowing, authProvider, userProvider,
                  user, currentUser, context);
        }),
        SizedBox(
          width: 10,
        ),
        ButtonOne(
          widget: Center(
              child: Text(
            'Enviar Mensaje',
            style: TextStyle(color: Colors.white),
          )),
          height: MediaQuery.of(context).size.height * .048,
          width: MediaQuery.of(context).size.width * .35,
          color: const Color.fromARGB(255, 101, 100, 100),
          radius: 10,
        ),
        SizedBox(
          width: 10,
        ),
        ButtonOne(
          widget: Icon(
            Icons.person_add_rounded,
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height * .048,
          width: MediaQuery.of(context).size.width * .1,
          color: const Color.fromARGB(255, 101, 100, 100),
          radius: 10,
        ),
      ],
    );
  }

  ButtonOne _buildButtonFollow(
      bool isFollowing,
      AuthProvider authProvider,
      UserProvider userProvider,
      UserModel? user,
      UserModel? currentUser,
      BuildContext context) {
    return ButtonOne(
      onTap: () {
        if (!isFollowing) {
          userProvider.addFollower(widget.user!.id, currentUser!.id);
          print(currentUser.following);
          print(user?.followers);
        }
      },
      widget: Center(
          child: Text(
        'Seguir',
        style: TextStyle(color: Colors.white),
      )),
      height: MediaQuery.of(context).size.height * .048,
      width: MediaQuery.of(context).size.width * .30,
      color: Color(0xFF1877F2),
      radius: 10,
    );
  }

  ButtonOne _buidButtonUnfollow(bool isFollowing, AuthProvider authProvider,
      UserProvider userProvider, UserModel? currentUser, BuildContext context) {
    return ButtonOne(
      onTap: () {
        if (isFollowing) {
          userProvider.removeFollower(widget.user!.id, currentUser!.id);
        }
      },
      widget: Center(
          child: Text(
        'Siguiendo',
        style: TextStyle(color: Colors.white),
      )),
      height: MediaQuery.of(context).size.height * .048,
      width: MediaQuery.of(context).size.width * .30,
      color: const Color.fromARGB(255, 101, 100, 100),
      radius: 10,
    );
  }
}

 */