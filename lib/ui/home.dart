import 'package:flutter/material.dart';
import 'package:bizapptrack/ui/list_to_excel.dart';
import 'package:bizapptrack/ui/login.dart';
import 'package:bizapptrack/ui/status.dart'; // Import your TestRenew page/widget

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userName = 'John'; // Replace with actual user name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bizapp Back Office',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 40.0),
            child: PopupMenuButton(
              icon: Icon(Icons.account_circle, color: Color.fromARGB(255, 237, 245, 255)),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: Text('Welcome, $_userName'),
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
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: const Color.fromARGB(255, 101, 102, 102),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://static.vecteezy.com/system/resources/previews/025/368/863/original/group-of-people-in-office-discussing-plan-graphic-illustration-ui-illustration-gui-ai-generated-png.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 45.0,
                  //left: 16.0,
                  right: 50.0,
                  child: Text(
                    'Welcome $_userName !',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 243, 251, 255),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Renew Status Bizapp User',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 70.0),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TestRenew()),
                          );
                        },
                        icon: Icon(Icons.check_circle, size: 40.0), // Set icon size
                        label: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Check Status',
                            style: TextStyle(fontSize: 14.0), // Set button text size
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, backgroundColor: Colors.grey, 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ), // Text color
                        ),
                      ),
                      SizedBox(height: 30.0),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ListToExcel()),
                          );
                        },
                        icon: Icon(Icons.file_download, size: 40.0), // Set icon size
                        label: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Export Excel',
                            style: TextStyle(fontSize: 14.0), // Set button text size
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, backgroundColor: Colors.grey, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ), // Text color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
