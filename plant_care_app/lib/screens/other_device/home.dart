import 'package:flutter/material.dart';
import 'package:plant_care_app/routes/app_routes.dart';
import 'package:plant_care_app/styles/app_style.dart';
import 'package:plant_care_app/utils/chart/data.dart';
import 'package:plant_care_app/utils/component/card/card.dart';
import 'package:plant_care_app/utils/component/double_text.dart';
import 'package:plant_care_app/utils/component/task/task.dart';
import 'package:plant_care_app/utils/plant_list_horizontal.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDoubleText(bigText: 'Plant Care', smallText: 'le mie piante'),
            SizedBox(height: 20),
            Center(child: SizedBox(height: 400, child: PlantList())),
            Text("Tasks", style: AppStyle.mobileHeadLine1),
            Task(
              annaffiare: DateTime.now(),
              potare: DateTime.now(),
              travasare: DateTime.now(),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed:
                    () => Navigator.pushNamed(context, AppRoutes.plantForm),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    AppStyle.bgButtonPositive,
                  ),
                ),
                child: Text('Nuova pianta', style: AppStyle.button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
