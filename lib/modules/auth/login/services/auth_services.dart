import 'dart:io';
import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/modules/application/application_page.dart';
import 'package:front_end_instagram/modules/auth/login/login_page.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/profile_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AuthServices {
  void login(BuildContext context, String email, String password) {
    if (password.isEmpty) {
      var snackbar = const SnackBar(
        content: Text('Ingresa tu contraseña',
            style: TextStyle(color: Colors.white)),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    } else if (password.length < 6) {
      var snackbar = const SnackBar(
        content: Text('La contraseña debe tener al menos 6 caracteres',
            style: TextStyle(color: Colors.white)),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }
    if (email.isEmpty) {
      var snackbar = const SnackBar(
        content:
            Text('Ingresa tu email', style: TextStyle(color: Colors.white)),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
        backgroundColor: Color.fromARGB(255, 255, 0, 0), // Rojo para error
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
        .hasMatch(email)) {
      var snackbar = const SnackBar(
        content: Text('Ingresa un email valido',
            style: TextStyle(color: Colors.white)),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    final user = userProvider.getUserByEmail(email);

    if (user != null && user.password == password && user.email == email) {
      authProvider.setLoggedIn(user);
      profileProvider.selectUser(user.id);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ApplicationPage()));
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Inicio de sesión exitoso!')));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error inicio de sesion')));
    }
  }

  void register(BuildContext context, String username, String email,
      String password, String confirm, File? file) {
    try {
      if (file == null) {
        var snackbar = const SnackBar(
          content: Text('Selecciona una imagen',
              style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
          backgroundColor: Color.fromARGB(255, 255, 0, 0), // Rojo para error
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }
      if (password != confirm) {
        var snackbar = const SnackBar(
          content: Text('Contraseñas no coinciden',
              style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
          backgroundColor: Color.fromARGB(255, 255, 0, 0), // Rojo para error
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }

      if (email.isEmpty) {
        var snackbar = const SnackBar(
          content:
              Text('Ingresa tu email', style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
          backgroundColor: Color.fromARGB(255, 255, 0, 0), // Rojo para error
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
          .hasMatch(email)) {
        var snackbar = const SnackBar(
          content: Text('Ingresa un email valido',
              style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }

      if (password.isEmpty) {
        var snackbar = const SnackBar(
          content: Text('Ingresa tu contraseña',
              style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      } else if (password.length < 6) {
        var snackbar = const SnackBar(
          content: Text('La contraseña debe tener al menos 6 caracteres',
              style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Este es un mensaje de prueba!')));
      final AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      final UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);

      var userId = Uuid().v4();

      final user = UserModel(
      
          description: '',
          posts: [],
          followers: [],
          following: [],
          password: password,
          id: userId,
          passwordConfirmation: confirm,
          username: username,
          email: email,
          photoUser: file.path);

      userProvider.saveUser(user);
      authProvider.setLoggedIn(user);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ApplicationPage()));
    } catch (error) {
      rethrow;
    }
  }
}


/*
void login(BuildContext context, String username, String password) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    final user = userProvider.getUserById(menu[1].id);

    if (user != null) {
      authProvider.setLoggedIn(user);
      profileProvider.selectUser(user.id);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ApplicationPage()));
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Inicio de sesión exitoso!')));
    }
  }
*/
/*
void register(
    BuildContext context,
    String username,
    String email,
    String password,
    String confirm,
  ) {
    final authProvider = Provider.of<AuthProvider>(context,listen: false);
    final userId = authProvider.currentUserId;
    print('USER $userId');
    final user =
        Provider.of<UserProvider>(context,listen: false).getUserById(userId.toString());
    try {
      if (password != confirm) {
        var snackbar = const SnackBar(
          content: Text('Contraseñas no coinciden',
              style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
          backgroundColor: Color.fromARGB(255, 255, 0, 0), // Rojo para error
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }

      if (email.isEmpty) {
        var snackbar = const SnackBar(
          content:
              Text('Ingresa tu email', style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
          backgroundColor: Color.fromARGB(255, 255, 0, 0), // Rojo para error
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
          .hasMatch(email)) {
        var snackbar = const SnackBar(
          content: Text('Ingresa un email valido',
              style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }

      if (password.isEmpty) {
        var snackbar = const SnackBar(
          content: Text('Ingresa tu contraseña',
              style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      } else if (password.length < 6) {
        var snackbar = const SnackBar(
          content: Text('La contraseña debe tener al menos 6 caracteres',
              style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 60),
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Este es un mensaje de prueba!')));
      final AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      authProvider.setLoggedIn(user);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ApplicationPage()));
    } catch (error) {
      print(error);
    }
  }
 */