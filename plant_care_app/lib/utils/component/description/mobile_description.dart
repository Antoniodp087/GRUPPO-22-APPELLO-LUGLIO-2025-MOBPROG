import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class AppDescriptionElementMobile extends StatelessWidget {
  const AppDescriptionElementMobile({
    super.key,
    required this.description,
    this.image,
  });

  final String description;
  final ImageProvider? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 450,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      child: Column(
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
                      ? Image.network(
                        (image as NetworkImage).url,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.broken_image));
                        },
                      )
                      : const SizedBox(),
            ),
          ),
          SizedBox(height: 10),
          Expanded(child: Text(description, style: AppStyle.mobileHeadLine2)),
        ],
      ),
    );
  }
}
