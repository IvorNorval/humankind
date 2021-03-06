import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      print(e);
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return const MaterialApp();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return const MaterialApp();
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primaryColor: const Color(0xff634310),
        focusColor: const Color(0xff634310),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xff634310),
          selectionColor: Color(0xff634310),
          selectionHandleColor: Color(0xff634310),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
