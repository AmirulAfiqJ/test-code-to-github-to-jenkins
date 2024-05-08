import 'package:bizapptrack/ui/home.dart';
import 'package:bizapptrack/ui/listToExcel.dart';
import 'package:bizapptrack/ui/status.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 55.0,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            title: Text('Renew Status Bizapp User'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TestRenew()));
            },
          ),
          ListTile(
            title: Text('Export Excel'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ListToExcel()));
            },
          ),
        ],
      ),
    );
  }
}
