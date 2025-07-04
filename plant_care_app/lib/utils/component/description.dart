import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class AppDescriptionElement extends StatelessWidget {
  const AppDescriptionElement({
    super.key,
    required this.description,
    this.image,
  });

  final String description;
  final ImageProvider? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      height: 450,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Container(
              width: 320,
              height: 324,
              color: AppStyle.bgCard,
              child:
                  image != null
                      ? Image(image: image!, fit: BoxFit.cover)
                      : const SizedBox(), // Vuoto se nessuna immagine
            ),
          ),
          SizedBox(width: 20),
          Expanded(child: Text(description, style: AppStyle.headLine3)),
        ],
      ),
    );
  }
}
