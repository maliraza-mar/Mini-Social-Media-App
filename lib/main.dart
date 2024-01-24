import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_socialmedia/auth/auth.dart';
import 'package:mini_socialmedia/auth/login_or_register.dart';
import 'package:mini_socialmedia/pages/home_page.dart';
import 'package:mini_socialmedia/pages/login_page.dart';
import 'package:mini_socialmedia/pages/profile_page.dart';
import 'package:mini_socialmedia/pages/users_page.dart';
import 'package:mini_socialmedia/theme/dark_mode.dart';
import 'package:mini_socialmedia/theme/light_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/users_page': (context) => const UsersPage(),
      },
    );
  }
}


