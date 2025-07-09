import 'package:flutter/material.dart';
import 'package:plant_care_app/utils/component/card/card.dart';
import 'package:plant_care_app/utils/component/card/card_mobile.dart';
import 'package:plant_care_app/utils/component/category/category.dart';
import 'package:plant_care_app/utils/component/description/description.dart';
import 'package:plant_care_app/utils/component/double_text.dart';
import 'package:plant_care_app/utils/component/category/mobile_category.dart';
import 'package:plant_care_app/utils/component/description/mobile_description.dart';
import 'package:plant_care_app/utils/component/mobile_double_text.dart';
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
        AppCardMobile(
          plantName: plant['nome'],
          image: NetworkImage(plant['immagine']),
        ),
        MobileAppDoubleText(bigText: plant['nome'], smallText: plant['specie']),

        AppDescriptionElementMobile(
          description: plant['descrizione'],

          //https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img,w_600,h_600/https://gachwala.in/wp-content/uploads/2022/06/IMAGE-1-13.webp
          image: NetworkImage(plant['immagine']),
        ),

        MobileAppCategory(category: plant['categoria']),

        MobileTask(),
        AppCard(
          plantName: plant['nome'],
          image: NetworkImage(plant['immagine']),
          plantType: plant['categoria'],
        ),
        AppDoubleText(bigText: 'Plant Care', smallText: 'le mie piante'),
        AppDoubleText(bigText: plant['nome'], smallText: plant['specie']),

        AppDescriptionElement(
          description: plant['descrizione'],
          image: NetworkImage(plant['immagine']),
        ),

        AppCategory(category: plant['categoria']),
      ],
    );
  }
}
