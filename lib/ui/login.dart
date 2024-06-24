import 'package:bizapptrack/utils/route.dart';
import 'package:bizapptrack/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Web View
                return LoginForm(isWeb: true);
              } else {
                // Mobile View
                return LoginForm(isWeb: false);
              }
            },
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final bool isWeb;

  LoginForm({required this.isWeb});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginViewModel viewModel = LoginViewModel();
  bool _isPasswordVisible = false;

  // Toggles the password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  // Method to handle login button pressed
  void _loginPressed(BuildContext context) {
    String email = viewModel.emailController.text.toLowerCase();
    String password = viewModel.passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Email and password must not be empty.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Check email and password combination
    for (var user in viewModel.loginList) {
      if (user.email.toLowerCase() == email) {
        if (user.password == password) {
          // Successful login
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => HomePage(username: user.username),
          //   ),
          // );
          Navigator.pushNamed(context, AppRoutes.home, arguments: {
            "username": user.username
          });
          return;
        } else {
          // Show error message if email and password do not match
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Login Failed'),
              content: const Text('Email and password do not match.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          return;
        }
      }
    }

    if(email.isNotEmpty && password.isNotEmpty) {
      Navigator.pushNamed(context, AppRoutes.home);
    }else{
      showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Login Failed'),
              content: const Text('Email and password do not match.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
    }
    // TODO :: dah fix, later call pass username and password ke API then dapat return untuk check betul or tak
    // // Check email and password combination
    // for (var user in viewModel.loginList) {
    //   if (user.email.toLowerCase() == email) {
    //     if (user.password == password) {
    //       // Successful login
          
    //       return;
    //     } else {
    //       // Show error message if email and password do not match
          
    //       return;
    //     }
    //   }
    // }

    // // Show error message if email does not exist in the validCredentials map
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('Login Failed'),
    //     content: const Text('You do not have access to this website.'),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.pop(context),
    //         child: const Text('OK'),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isWeb) {
      // Web View
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left Container for Login Fields
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 198, 197, 197),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bizapp Back Office',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: viewModel.emailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 41, 41, 41)
                            )
                            
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: viewModel.passwordController,
                          style: const TextStyle(color: Colors.black),
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                               labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 41, 41, 41)
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _togglePasswordVisibility,
                              child: Icon(
                                color: Colors.black,
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          onSubmitted: (_) => _loginPressed(context),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _loginPressed(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Right Container for Logo and Text
            Expanded(
            
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 50, 49, 49),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://static.vecteezy.com/system/resources/previews/010/872/897/non_2x/3d-graphic-designer-working-in-office-png.png',
                          width: 250,
                          height: 250,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Hello, welcome to Bizapp Back Office!',
                          style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
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
    } else {
      // Mobile View
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top Container for Logo and Text
            Flexible(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 50, 49, 49),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://static.vecteezy.com/system/resources/previews/010/872/897/non_2x/3d-graphic-designer-working-in-office-png.png',
                          width: 180,
                          height: 180,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Bizapp Back Office',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            // fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Container for Login Fields
            Flexible(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 198, 197, 197),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(
                        //   'Bizapp Back Office',
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: viewModel.emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                               labelStyle: TextStyle(
                              color: Color.fromARGB(255, 41, 41, 41)
                            )
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: viewModel.passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                               labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 41, 41, 41)
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _togglePasswordVisibility,
                              child: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          onSubmitted: (_) => _loginPressed(context),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _loginPressed(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
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
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
