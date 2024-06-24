import 'package:bizapptrack/ui/customAppBar.dart';
import 'package:bizapptrack/ui/expiring.dart';
import 'package:bizapptrack/ui/inactive.dart';
import 'package:bizapptrack/ui/newRenew.dart';
import 'package:bizapptrack/ui/others.dart';
import 'package:bizapptrack/ui/sideNav.dart';
import 'package:bizapptrack/ui/support.dart';
import 'package:flutter/material.dart';
import 'package:bizapptrack/utils/route.dart';
import 'package:bizapptrack/viewmodel/home_viewmodel.dart';

class HomePage extends StatefulWidget {

  // final String username;

  // HomePage({
  //   required this.username
  //   });

  HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeViewModel viewModel = HomeViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.getPref(context);
    print(viewModel.username);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    const buttonWidth = 200.0;
    const buttonHeight = 50.0;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(username: viewModel.username, scaffoldKey: _scaffoldKey),
           body: Row(
        children: [
          SideDrawer(username: viewModel.username), // Add the side navigation here
          Expanded(
            child: Container(
              // color: Color.fromARGB(255, 243, 251, 255),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 70.0),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NewCustomer()),
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
                              MaterialPageRoute(builder: (context) => Inactive()),
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
                              MaterialPageRoute(builder: (context) => Expiring()),
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
                              MaterialPageRoute(builder: (context) => Others()),
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
                              MaterialPageRoute(builder: (context) => SupportPage()),
                            );
                          },
                          icon: Icon(Icons.support_agent, size: 30.0), // Set icon size
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