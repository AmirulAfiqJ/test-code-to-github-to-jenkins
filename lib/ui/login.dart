import 'package:bizapptrack/ui/home.dart';
import 'package:bizapptrack/utils/route.dart';
import 'package:bizapptrack/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
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

    if(email.isNotEmpty && password.isNotEmpty) {
      Navigator.pushNamed(context, AppRoutes.login);
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
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Left Container for Login Fields
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 198, 197, 197),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextField(
                      controller: viewModel.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: viewModel.passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
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

          // Right Container for Logo and Text
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 50, 49, 49),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
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
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(height: 60),
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
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
