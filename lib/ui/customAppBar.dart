import 'package:bizapptrack/main.dart';
import 'package:flutter/material.dart';
import 'package:bizapptrack/ui/login.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final GlobalKey<ScaffoldState> scaffoldKey;

  CustomAppBar({required this.username, required this.scaffoldKey});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: Text(
        'Bizapp Back Office',
        style: TextStyle(
          color: Color.fromARGB(255, 243, 241, 241),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      // leading: IconButton(
      //   icon: const Icon(Icons.menu, color: Color.fromARGB(255, 223, 221, 221)),
      //   onPressed: () {
      //     scaffoldKey.currentState!.openDrawer();
      //   },
      // ),
      actions: [
        ThemeSwitcher(),
        Padding(
          padding: EdgeInsets.only(right: 40.0),
          child: PopupMenuButton(
            icon: Icon(Icons.account_circle, color: Color.fromARGB(255, 237, 245, 255)),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text('Welcome, $username'),
                enabled: false,
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
