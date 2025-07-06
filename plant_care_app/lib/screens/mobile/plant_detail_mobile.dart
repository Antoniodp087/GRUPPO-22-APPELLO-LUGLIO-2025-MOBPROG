import 'package:flutter/material.dart';
import 'package:plant_care_app/screens/all_plant.dart';
import 'package:plant_care_app/utils/chart/data.dart';
import 'package:plant_care_app/utils/component/mobile_double_text.dart';

class PlantDetailMobile extends StatelessWidget {
  const PlantDetailMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MobileAppDoubleText(bigText: 'Plant Care', smallText: 'le mie piante'),
        SizedBox(
          height: 400,
          child: ListView(
            scrollDirection: Axis.vertical,
            children:
                plantsList
                    .map(
                      (singlePlant) => Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: AllPlantMobile(plant: singlePlant),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}
