import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/modules/auth/login/login_page.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AppProfilePage extends StatefulWidget {
  const AppProfilePage({super.key, this.user});
  final UserModel? user;
  @override
  State<AppProfilePage> createState() => _AppProfilePageState();
}

class _AppProfilePageState extends State<AppProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .1,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.user?.username ?? 'asdas',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_box_outlined,
                        color: Colors.white, size: 25)),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'logout') {
                      final auth =
                          Provider.of<AuthProvider>(context, listen: false);
                      auth.logOut();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    }
                  },
                  icon: const Icon(Icons.menu_outlined,
                      color: Colors.white, size: 30),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'logout',
                        child: Text('Cerrar sesión'),
                      ),
                    ];
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
