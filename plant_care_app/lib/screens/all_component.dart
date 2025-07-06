import 'package:flutter/material.dart';
import 'package:plant_care_app/utils/component/card/card.dart';
import 'package:plant_care_app/utils/component/card/card_mobile.dart';
import 'package:plant_care_app/utils/component/category.dart';
import 'package:plant_care_app/utils/component/description.dart';
import 'package:plant_care_app/utils/component/double_text.dart';
import 'package:plant_care_app/utils/component/mobile_category.dart';
import 'package:plant_care_app/utils/component/mobile_description.dart';
import 'package:plant_care_app/utils/component/mobile_double_text.dart';
import 'package:plant_care_app/utils/component/task/task.dart';
import 'package:plant_care_app/utils/component/task/task_mobile.dart';

class AllComponent extends StatelessWidget {
  const AllComponent({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime oggi = DateTime.now();
    DateTime domani = oggi.add(Duration(days: 1));
    DateTime ieri = oggi.subtract(Duration(days: 1));
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MobileAppDoubleText(
                bigText: 'Plant Care',
                smallText: 'le mie piante',
              ),
              MobileAppCategory(category: 'categoria1', number: 4),
              AppCardMobile(plantName: "nome pianta"),
              AppDescriptionElementMobile(description: "description"),
              MobileTask(annaffiare: oggi, potare: domani, travasare: ieri),

              //AppStyle.smilingFaceEmoji,
              //AppStyle.pottedPlantEmojiMobile,
              //AppStyle.house,
              //AppStyle.houseMobile,
              //AppStyle.houseMobileActive,
              //
              AppDoubleText(bigText: 'Plant Care', smallText: 'le mie piante'),
              AppCategory(category: 'categoria2', number: 3),
              AppCard(plantName: 'plantName', plantType: "plant"),
              AppDescriptionElement(description: "description"),
              Task(annaffiare: oggi, potare: domani, travasare: ieri),
            ],
          ),
        ),
      ),
    );
  }
}
