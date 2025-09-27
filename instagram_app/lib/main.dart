import 'package:flutter/material.dart';
import 'package:instagram_app/viewmodels/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'app/themes.dart';
import 'views/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark, // Automatically switches based on system theme
      home: LoginScreen(),
    );
  }
}
