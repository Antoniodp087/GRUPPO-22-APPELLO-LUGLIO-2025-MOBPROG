import 'package:flutter/material.dart';
import 'package:plant_care_app/responsive/responsive_base.dart';
import 'package:plant_care_app/routes/app_routes.dart';
import 'package:plant_care_app/screens/mobile/n_m_category_mobile.dart';
import 'package:plant_care_app/screens/mobile/n_m_plant_mobile.dart';
import 'package:plant_care_app/screens/other_device/n_m_category.dart';
import 'package:plant_care_app/screens/other_device/n_m_plant.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:desktop_window/desktop_window.dart';
import 'dart:io';

void main() async {
  // Inizializza sqflite_common_ffi
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  databaseFactory = databaseFactoryFfi;
  final dbPath = await getDatabasesPath();
  print('Database : $dbPath');

  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    await DesktopWindow.setWindowSize(const Size(610, 1000));
  }

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
          AppRoutes.categoryForm: (context) => CategoryForm(),
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