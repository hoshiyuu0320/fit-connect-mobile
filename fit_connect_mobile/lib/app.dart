import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FIT-CONNECT',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Text('FIT-CONNECT Mobile'),
        ),
      ),
    );
  }
}