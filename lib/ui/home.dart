import 'package:bizapptrack/ui/expiring.dart';
import 'package:bizapptrack/ui/inactive.dart';
import 'package:bizapptrack/ui/newRenew.dart';
import 'package:bizapptrack/ui/others.dart';
import 'package:bizapptrack/ui/support.dart';
import 'package:flutter/material.dart';
import 'package:bizapptrack/ui/login.dart';
class HomePage extends StatefulWidget {
  final String username;
  HomePage({required this.username});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final buttonWidth = 200.0;
    final buttonHeight = 50.0;

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
              icon: Icon(Icons.account_circle,
                  color: Color.fromARGB(255, 237, 245, 255)),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: Text('Welcome, ${widget.username}!'),
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
                  right: 50.0,
                  child: Text(
                    'Welcome ${widget.username}!',
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
                        'Bizapp User Status',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 70.0),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NewCustomer(username: widget.username)),
                            );
                          },
                          icon: Icon(Icons.fiber_new, size: 30.0), // Set icon size
                          label: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'New & Renew',
                              style: TextStyle(fontSize: 14.0), // Set button text size
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Color.fromARGB(255, 173, 185, 242),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ), // Text color
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Inactive(username: widget.username)),
                          );
                        },
                        icon: Icon(Icons.remove_circle_outline, size: 30.0), // Set icon size
                        label: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Inactive',
                            style: TextStyle(fontSize: 14.0), // Set button text size
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Color.fromARGB(255, 255, 228, 138),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ), // Text color
                        ),
                      ), 
                      ),
                      SizedBox(height: 30.0),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Expiring(username: widget.username)),
                          );
                        },
                        icon: Icon(Icons.access_time, size: 30.0), // Set icon size
                        label: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Expiring',
                            style: TextStyle(fontSize: 14.0), // Set button text size
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Color.fromARGB(255, 255, 172, 172),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ), // Text color
                        ),
                      ),
                      ),

                      SizedBox(height: 30.0),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Others(username: widget.username)),
                          );
                        },
                        icon: Icon(Icons.category, size: 30.0), // Set icon size
                        label: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Others',
                            style: TextStyle(fontSize: 14.0), // Set button text size
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color.fromARGB(255, 197, 196, 196),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ), // Text color
                        ),
                      ),
                      ),
                      SizedBox(height: 30.0),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SupportPage(username: widget.username)),
                          );
                        },
                        icon: Icon(Icons.category, size: 30.0), // Set icon size
                        label: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Support',
                            style: TextStyle(fontSize: 14.0), // Set button text size
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Color.fromARGB(255, 112, 211, 101),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ), // Text color
                        ),
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