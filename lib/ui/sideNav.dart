import 'package:bizapptrack/ui/expiring.dart';
import 'package:bizapptrack/ui/home.dart';
import 'package:bizapptrack/ui/inactive.dart';
import 'package:bizapptrack/ui/newRenew.dart';
import 'package:bizapptrack/ui/others.dart';
import 'package:bizapptrack/ui/support.dart';
import 'package:flutter/material.dart';
import 'package:bizapptrack/ui/drawerState.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatelessWidget {
  final String username;

  const SideDrawer({required this.username});

  @override
  Widget build(BuildContext context) {
    bool isDrawerOpen = context.watch<DrawerState>().isDrawerOpen;

    return isDrawerOpen ? _buildOpenDrawer(context) : _buildClosedDrawer(context);
  }

  Widget _buildOpenDrawer(BuildContext context) {
    return Container(
      width: 180, // Set the desired width here
      child: Drawer(
        backgroundColor: Color.fromARGB(255, 36, 36, 36),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.read<DrawerState>().toggleDrawer();
                    },
                  ),
                ],
              ),
            ),
            _buildListTile(Icons.home, 'Dashboard', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(username: username),
                ),
              );
            },
            iconColor: Colors.white,
            textColor: Colors.white,
            ),
            _buildListTile(Icons.fiber_new, 'New/Renew', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewCustomer(username: username),
                ),
              );
            },
            iconColor: Colors.white,
            textColor: Colors.white,
            ),
            _buildListTile(Icons.remove_circle_outline, 'Inactive', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Inactive(username: username),
                ),
              );
            },
            iconColor: Colors.white,
            textColor: Colors.white,
            ),
            _buildListTile(Icons.access_time, 'Expiring', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Expiring(username: username),
                ),
              );
            },
            iconColor: Colors.white,
            textColor: Colors.white,
            ),
            _buildListTile(Icons.category, 'Others', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Others(username: username),
                ),
              );
            },
            iconColor: Colors.white,
            textColor: Colors.white,
            ),
            _buildListTile(Icons.support_agent, 'Support', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SupportPage(username: username),
                ),
              );
            },
            iconColor: Colors.white,
            textColor: Colors.white,),
          ],
        ),
      ),
    );
  }

  Widget _buildClosedDrawer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      color: Color.fromARGB(255, 36, 36, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<DrawerState>().toggleDrawer();
            },
          ),
          SizedBox(height: 23), // Add some space between the menu icon and the home icon
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(username: username),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(3)),
                Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 23), // Add some space between the menu icon and the home icon
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewCustomer(username: username),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(3)),
                Icon(
                  Icons.fiber_new,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 23), // Add some space between the menu icon and the home icon
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Inactive(username: username),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(3)),
                Icon(
                  Icons.remove_circle_outline,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 23), // Add some space between the menu icon and the home icon
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Expiring(username: username),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(3)),
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 23), // Add some space between the menu icon and the home icon
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Others(username: username),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(3)),
                Icon(
                  Icons.category,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 23), // Add some space between the menu icon and the home icon
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SupportPage(username: username),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(3)),
                Icon(
                  Icons.support_agent,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap,
      {Color iconColor = Colors.white, Color textColor = Colors.white}) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
      onTap: onTap,
    );
  }
}
