
import 'package:flutter/material.dart';
//import 'PageLogin.dart';
// ignore_for_file: prefer_const_constructors
class PagePosition extends StatelessWidget {

  PagePosition({required this.posisi});
  final String posisi;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PagePosition"),
      ),
      body: Center(
        child: Text(posisi)
      ),
    );
  }

}