import 'package:bizapptrack/ui/customAppBar.dart';
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
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: const Color.fromARGB(255, 101, 102, 102),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
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
                    'Welcome ${viewModel.username}!',
                    style: const TextStyle(
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
              // color: Color.fromARGB(255, 243, 251, 255),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70.0),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => NewCustomer(username: viewModel.username)),
                            // );
                            Navigator.pushNamed(context, AppRoutes.newRenew, arguments: {
                              "username": viewModel.username
                            });
                          },
                          icon: const Icon(Icons.fiber_new, size: 30.0), // Set icon size
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'New & Renew',
                              style: TextStyle(fontSize: 14.0), // Set button text size
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: const Color.fromARGB(255, 173, 185, 242),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ), // Text color
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Inactive(username: widget.username)),
                            // );
                            Navigator.pushNamed(context, AppRoutes.inactive, arguments: {
                            "username": viewModel.username
                          });
                          },
                          icon: const Icon(Icons.remove_circle_outline, size: 30.0), // Set icon size
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Inactive',
                              style: TextStyle(fontSize: 14.0), // Set button text size
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: const Color.fromARGB(255, 255, 228, 138),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ), // Text color
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Expiring(username: widget.username)),
                          // );
                          Navigator.pushNamed(context, AppRoutes.expiring, arguments: {
                              "username": viewModel.username
                            });
                        },
                        icon: const Icon(Icons.access_time, size: 30.0), // Set icon size
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Expiring',
                            style: TextStyle(fontSize: 14.0), // Set button text size
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color.fromARGB(255, 255, 172, 172),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ), // Text color
                        ),
                      ),
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Others(username: widget.username)),
                            // );
                            Navigator.pushNamed(context, AppRoutes.others, arguments: {
                            "username": viewModel.username
                            });
                          },
                          icon: const Icon(Icons.category, size: 30.0), // Set icon size
                          label: const Padding(
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
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => SupportPage(username: widget.username)),
                            // );
                            Navigator.pushNamed(context, AppRoutes.support, arguments: {
                            "username": viewModel.username
                          });
                          },
                          icon: const Icon(Icons.support_agent, size: 30.0), // Set icon size
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Support',
                              style: TextStyle(fontSize: 14.0), // Set button text size
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: const Color.fromARGB(255, 112, 211, 101),
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
