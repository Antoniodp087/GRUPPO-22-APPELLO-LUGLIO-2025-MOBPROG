import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: Scaffold(
          body: Center(
            child: CheckboxListTile(
              title: const Text('CheckboxListTile with red background'),
              value: false,
              onChanged: (value) => (),
            ),
          ),
        ),
      ),
    );
  }
}
