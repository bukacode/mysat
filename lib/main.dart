
import 'package:flutter/material.dart';
import 'PageLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MySat',
      home: PageLogin(),
    );
  }
}
