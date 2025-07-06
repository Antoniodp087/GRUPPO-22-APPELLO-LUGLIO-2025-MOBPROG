import 'package:flutter/material.dart';
import 'package:plant_care_app/screens/all_plant.dart';
import 'package:plant_care_app/utils/chart/data.dart';

class PlantDetailMobile extends StatelessWidget {
  const PlantDetailMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children:
            plantsList
                .map(
                  (singlePlant) => Container(
                    //constraints: BoxConstraints(minWidth: 20, maxWidth: 200),
                    margin: EdgeInsets.only(bottom: 20),
                    child: AllPlantMobile(plant: singlePlant),
                  ),
                )
                .toList(),
      ),
    );
    ;
  }
}
