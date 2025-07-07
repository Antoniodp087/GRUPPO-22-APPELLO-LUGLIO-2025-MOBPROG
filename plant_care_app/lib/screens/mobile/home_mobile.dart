import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';
import 'package:plant_care_app/utils/chart/data.dart';
import 'package:plant_care_app/utils/component/card/card_mobile.dart';
import 'package:plant_care_app/utils/component/mobile_double_text.dart';
import 'package:plant_care_app/utils/component/task/task_mobile.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MobileAppDoubleText(
            bigText: 'Plant Care',
            smallText: 'le mie piante',
          ),
          SizedBox(height: 20),
          Center(
            child: SizedBox(
              height: 400,
              width: 350,
              child: ListView(
                scrollDirection: Axis.vertical,
                children:
                    plantsList
                        .map(
                          (singlePlant) => Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: AppCardMobile(
                              plantName: singlePlant['nome'],
                              image: NetworkImage(singlePlant['immagine']),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
          Text("Tasks", style: AppStyle.mobileHeadLine1),
          MobileTask(
            annaffiare: DateTime.now(),
            potare: DateTime.now(),
            travasare: DateTime.now(),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/mobile-form'),

              //Navigator.pushNamed(context, '/form'),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  AppStyle.bgButtonPositive,
                ),
              ),
              child: Text('Nuova pianta', style: AppStyle.mobileButton),
            ),
          ),
        ],
      ),
    );
  }
}
