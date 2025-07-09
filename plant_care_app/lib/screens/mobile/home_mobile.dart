import 'package:flutter/material.dart';
import 'package:plant_care_app/routes/app_routes.dart';
import 'package:plant_care_app/styles/app_style.dart';
import 'package:plant_care_app/utils/component/mobile_double_text.dart';
import 'package:plant_care_app/utils/component/task/task_mobile.dart';
import 'package:plant_care_app/utils/plant_list_vertical.dart';

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
          SizedBox(height: 10),
          Center(
            child: SizedBox(height: 350, width: 350, child: MobilePlantList()),
          ),
          Text("Tasks", style: AppStyle.mobileHeadLine1),
          MobileTask(),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed:
                  () => Navigator.pushNamed(context, AppRoutes.plantMobileForm),

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
