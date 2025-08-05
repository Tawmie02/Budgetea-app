import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:budgetea_v1/theme/theme.dart';
import 'package:budgetea_v1/widgets/custom_scaffold.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budgetea',
      theme: lightMode,
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
