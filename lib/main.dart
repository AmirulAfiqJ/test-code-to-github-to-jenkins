import 'package:bizapptrack/ui/login.dart';
import 'package:bizapptrack/viewmodel/status_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

// test action
Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    usePathUrlStrategy();

    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => StatusController())
        ],
        child: const MyApp()));
  } catch (error) {
    debugPrint("error di main.dart:: $error");
    debugPrint(error.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bizapp Status',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            constraints: const BoxConstraints(maxHeight: 650, maxWidth: 1400), // Limit width
            decoration: const BoxDecoration(
              //color: Color.fromARGB(255, 198, 197, 197), // Change color here
              //borderRadius: BorderRadius.circular(25), // Set border radius
            ),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
