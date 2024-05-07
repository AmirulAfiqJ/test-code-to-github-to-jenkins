import 'package:bizapptrack/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:bizapptrack/ui/status.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Regular expression pattern for validating email format
  final emailPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@bizapp\.my$');

  // Password validation rules
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null; // Return null if password is valid
  }

  // Toggles the password visibility
  bool _isPasswordVisible = false;
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  // Method to handle login button pressed
  void _loginPressed(BuildContext context) {
    // Validate email format
    if (!emailPattern.hasMatch(emailController.text)) {
      // Show error message if email format is invalid
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Email'),
          content: Text('Please enter a valid email address ending with @bizapp.my'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Validate password
    String? passwordError = validatePassword(passwordController.text);
    if (passwordError != null) {
      // Show error message if password is invalid
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Password'),
          content: Text(passwordError),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

   // Navigate to Home Page after successful login
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),  // Navigate to HomePage
    );
  }

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left Container for Login Fields
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 198, 197, 197), // Set container color
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
                  Text(
                    'Bizapp Back Office',
                    style: TextStyle(
                      fontSize: 24, // Adjust font size as needed
                      fontWeight: FontWeight.bold, // Make the title bold
                    ),
                  ),
                  SizedBox(height: 50), // Add spacing below the title
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: GestureDetector(
                        onTap: _togglePasswordVisibility,
                        child: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _loginPressed(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
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
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 50, 49, 49), // Set container color
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
                  'https://static.vecteezy.com/system/resources/previews/010/872/897/non_2x/3d-graphic-designer-working-in-office-png.png', // Provide the path to your logo image
                  width: 300, // Adjust width as needed
                  height: 300, // Adjust height as needed
                  // You can also use other properties like fit, alignment, etc.
                  ),
                  SizedBox(height: 60),
                  Text(
                    'Hello, welcome to Bizapp Back Office!',
                    style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic, color: Colors.white),
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