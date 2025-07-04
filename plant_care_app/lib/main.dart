import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_care_app/styles/app_style.dart';
import 'package:plant_care_app/utils/component/card/card.dart';
import 'package:plant_care_app/utils/component/card/card_mobile.dart';
import 'package:plant_care_app/utils/component/category.dart';
import 'package:plant_care_app/utils/component/description.dart';
import 'package:plant_care_app/utils/component/double_text.dart';
import 'package:plant_care_app/utils/component/mobile_category.dart';
import 'package:plant_care_app/utils/component/mobile_description.dart';
import 'package:plant_care_app/utils/component/mobile_double_text.dart';

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CheckboxListTile(
                    title: FaIcon(FontAwesomeIcons.magnifyingGlass),
                    value: false,
                    onChanged: (value) => (),
                  ),
                  AppDoubleText(
                    bigText: 'Plant Care',
                    smallText: 'le mie piante',
                  ),
                  MobileAppDoubleText(
                    bigText: 'Plant Care',
                    smallText: 'le mie piante',
                  ),

                  //AppStyle.smilingFaceEmoji,
                  //AppStyle.pottedPlantEmojiMobile,
                  //AppStyle.house,
                  //AppStyle.houseMobile,
                  //AppStyle.houseMobileActive,
                  //AppCategory(category: 'categoria1'),
                  //MobileAppCategory(category: 'categoria1'),
                  //AppCardMobile(plantName: "nome pianta"),
                  AppDescriptionElementMobile(description: "description"),
                  AppCard(plantName: 'plantName', plantType: "plant"),
                  AppDescriptionElement(description: "description"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
