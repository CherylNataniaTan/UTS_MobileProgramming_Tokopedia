import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'services/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguageManager.loadLanguage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UntarianMart',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
