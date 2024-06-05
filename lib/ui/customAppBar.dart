import 'package:bizapptrack/utils/route.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final GlobalKey<ScaffoldState> scaffoldKey;

  CustomAppBar({required this.username, required this.scaffoldKey});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Bizapp Back Office',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: PopupMenuButton(
            icon: const Icon(Icons.account_circle, color: Color.fromARGB(255, 237, 245, 255)),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                enabled: false,
                child: Text('Welcome, $username'),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Logout'),
                  onTap: () {
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    //   (route) => false,
                    // );
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
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
