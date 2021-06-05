import 'package:bytebank/screens/tranfers_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent[700],
        accentColor: Colors.red[900],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red[900],
          ),
        ),
      ),
      home: TransferList(),
    );
  }
}
