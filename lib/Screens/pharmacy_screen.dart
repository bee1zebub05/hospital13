import 'package:flutter/material.dart';

class PharmacyScreen extends StatelessWidget {
  static String routeName = 'PharmacyScreen';  // Định nghĩa routeName cho PharmacyScreen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacy Screen'),
      ),
      body: Center(
        child: Text('Welcome to Pharmacy Screen!'),
      ),
    );
  }
}

