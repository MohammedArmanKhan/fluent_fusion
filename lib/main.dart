import 'package:fluent_fusion/screens/login_screen.dart';
import 'package:fluent_fusion/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluent_fusion/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluent_fusion/resources/auth_methods.dart';
import 'package:fluent_fusion/screens/video_call_screen.dart';

// Import firebase core and generated file

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Load widgets first then firebase auth
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // try {
  //   await Firebase.initializeApp();
  //   print('Firebase initialized successfully!');
  // } catch (e) {
  //   print('Error initializing Firebase: $e');
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluent Fusion',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),

      },
      home: StreamBuilder(
          stream: AuthMethods().authChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const LoginScreen();
          }
      ),
    );
  }
}
