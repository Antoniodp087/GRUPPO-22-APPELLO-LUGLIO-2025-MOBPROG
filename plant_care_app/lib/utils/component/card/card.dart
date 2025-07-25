import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.plantName,
    required this.plantType,
    this.image,
  });

  final String plantName;
  final String plantType;
  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 830,
      height: 340,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
      child: Card(
        color: AppStyle.bgCard,
        child: InkWell(
          splashColor: AppStyle.bgCard,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Container(
                    width: 250,
                    height: 250,
                    color: Colors.white,
                    child:
                        image != null
                            ? Image.network(
                              (image as NetworkImage).url,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(Icons.broken_image),
                                );
                              },
                            )
                            : const SizedBox(),
                  ),
                ),
              ),
              SizedBox(width: 50),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(plantName, style: AppStyle.cardTitle),
                    Text(plantType, style: AppStyle.cardSubTitle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
