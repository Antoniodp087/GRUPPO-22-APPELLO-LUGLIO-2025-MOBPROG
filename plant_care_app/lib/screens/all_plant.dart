import 'package:flutter/material.dart';
import 'package:plant_care_app/utils/component/category.dart';
import 'package:plant_care_app/utils/component/description.dart';
import 'package:plant_care_app/utils/component/double_text.dart';
import 'package:plant_care_app/utils/component/mobile_category.dart';
import 'package:plant_care_app/utils/component/mobile_description.dart';
import 'package:plant_care_app/utils/component/mobile_double_text.dart';
import 'package:plant_care_app/utils/component/task/task.dart';
import 'package:plant_care_app/utils/component/task/task_mobile.dart';

class AllPlantMobile extends StatelessWidget {
  const AllPlantMobile({super.key, required this.plant});
  final Map<String, dynamic> plant;

  @override
  Widget build(BuildContext context) {
    print(plant['immagine']);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MobileAppDoubleText(bigText: 'Plant Care', smallText: 'le mie piante'),
        MobileAppDoubleText(bigText: plant['nome'], smallText: plant['specie']),

        AppDescriptionElementMobile(
          description: plant['descrizione'],
          image: NetworkImage(plant['immagine']),
        ),

        MobileAppCategory(category: plant['categoria']),

        MobileTask(
          annaffiare: DateTime.parse(plant['ultima_innaffiatura']),
          potare: DateTime.parse(plant['ultima_potatura']),
          travasare: DateTime.parse(plant['ultima_travasatura']),
        ),
        AppDoubleText(bigText: 'Plant Care', smallText: 'le mie piante'),
        AppDoubleText(bigText: plant['nome'], smallText: plant['specie']),

        AppDescriptionElement(
          description: plant['descrizione'],
          image: NetworkImage(plant['immagine']),
        ),

        AppCategory(category: plant['categoria']),
        Task(
          annaffiare: DateTime.parse(plant['ultima_innaffiatura']),
          potare: DateTime.parse(plant['ultima_potatura']),
          travasare: DateTime.parse(plant['ultima_travasatura']),
        ),
      ],
    );
  }
}
