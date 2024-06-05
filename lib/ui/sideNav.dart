import 'package:bizapptrack/ui/expiring.dart';
import 'package:bizapptrack/ui/inactive.dart';
import 'package:bizapptrack/ui/newRenew.dart';
import 'package:bizapptrack/ui/others.dart';
import 'package:bizapptrack/utils/route.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final String username;
  const SideDrawer({required this.username});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 55.0,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(username: username)));
              Navigator.pushNamed(context, AppRoutes.home, arguments: {
                "username": username
              });
            },
          ),
          ListTile(
            title: const Text('New/Renew User'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewCustomer(username: username)));
            },
          ),
          ListTile(
            title: const Text('Expiring User'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Expiring(username: username)));
            },
          ),
          ListTile(
            title: const Text('Inactive User'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Inactive(username: username)));
            },
          ),
          ListTile(
            title: const Text('Others'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Others(username: username)));
            },
          ),
          ListTile(
            title: const Text('Support'),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SupportPage(username: username)));
              Navigator.pushNamed(context, AppRoutes.support, arguments: {
                "username": username
              });
            },
          ),
        ],
      ),
    );
  }
}
