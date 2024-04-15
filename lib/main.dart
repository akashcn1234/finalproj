import 'package:flutter/material.dart';

import '../db/shared_pref.dart';
import 'modules/auth/login.dart';



void main() async{

   WidgetsFlutterBinding.ensureInitialized();

  await DbService.init();

  


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade100),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white
      ),
      home: LoginScreen(),
    );
  }
}