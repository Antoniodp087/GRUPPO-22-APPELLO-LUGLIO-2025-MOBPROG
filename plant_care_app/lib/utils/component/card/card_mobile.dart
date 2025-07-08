import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class AppCardMobile extends StatelessWidget {
  const AppCardMobile({super.key, required this.plantName, this.image});

  final String plantName;
  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 138,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),

      child: Card(
        color: AppStyle.bgCard,
        child: InkWell(
          splashColor: AppStyle.bgCard,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.white,
                    child:
                        image != null
                            ? Image(image: image!, fit: BoxFit.cover)
                            : const SizedBox(), // Vuoto se nessuna immagine
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(child: Text(plantName, style: AppStyle.cardMobile)),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
