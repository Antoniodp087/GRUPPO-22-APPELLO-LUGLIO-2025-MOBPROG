import 'package:flutter/material.dart';
import 'package:plant_care_app/responsive/responsive_base.dart';
import 'package:plant_care_app/routes/app_routes.dart';
import 'package:plant_care_app/screens/mobile/n_m_category_mobile.dart';
import 'package:plant_care_app/screens/mobile/n_m_plant_mobile.dart';
import 'package:plant_care_app/screens/other_device/n_m_plant_detail.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  // Inizializza sqflite_common_ffi
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

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
        routes: {
          //'/': (context) => const PlantListPage(),
          AppRoutes.plantMobileForm: (context) => const MobileForm(),
          AppRoutes.plantForm: (context) => AppForm(),
          AppRoutes.categoryMobileForm: (context) => CategoryMobileForm(),
        },
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