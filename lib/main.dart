import 'package:bizapptrack/ui/home.dart';
import 'package:bizapptrack/ui/login.dart';
import 'package:bizapptrack/utils/route.dart';
import 'package:bizapptrack/viewmodel/status_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:bizapptrack/viewmodel/themeViewModel.dart';
import 'package:bizapptrack/ui/drawerState.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    usePathUrlStrategy();

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StatusController()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DrawerState()),

      ],
      child: const MyApp(),
    ));
  } catch (error) {
    debugPrint("error di main.dart:: $error");
    debugPrint(error.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // return MaterialApp(
    //   title: 'Bizapp Back Office',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: Scaffold(
    //     body: Center(
    //       child: Container(
    //         padding: const EdgeInsets.all(20.0),
    //         constraints: const BoxConstraints(maxHeight: 650, maxWidth: 1400), // Limit width
    //         decoration: const BoxDecoration(
    //           //color: Color.fromARGB(255, 198, 197, 197), // Change color here
    //           //borderRadius: BorderRadius.circular(25), // Set border radius
    //         ),
    //         /// TODO:
    //         child: LoginForm(isWeb: true),
    //       ),
    //     ),
    //   ),
    //   debugShowCheckedModeBanner: false,
    //   routes: AppRoutes.getRoutes(),
    //   onGenerateRoute: (_) {
    //     return MaterialPageRoute(builder: (context) => HomePage());
    //   },
    // );
    return MaterialApp(
      title: 'Bizapp Back Office',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.getRoutes(),
      onGenerateRoute: (_) {
        return MaterialPageRoute(builder: (context) => HomePage());
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Bizapp Status'),
        actions: const [
          ThemeSwitcher(),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          constraints: const BoxConstraints(maxHeight: 650, maxWidth: 1400),
          child:  LoginPage(),
        ),
      ),
    );
  }
}

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        themeProvider.toggleTheme(value);
      },
    );
  }
}