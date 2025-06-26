import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'example.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  /// Default Constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plugin Fultter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white, 
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/example': (context) => const ExamplePage(),
      },

    );
  }
}