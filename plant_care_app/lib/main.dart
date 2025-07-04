import 'package:flutter/material.dart';
import 'package:plant_care_app/responsive/responsive_base.dart';

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
        home: ResponsiveBase(),
      ),
    );
  }
}

//**


//
//
//
//
//
//
//
// 
// */