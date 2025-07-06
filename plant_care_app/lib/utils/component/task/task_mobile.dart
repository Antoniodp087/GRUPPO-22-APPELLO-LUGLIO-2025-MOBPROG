import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class MobileTask extends StatefulWidget {
  const MobileTask({
    super.key,
    required this.annaffiare,
    required this.potare,
    required this.travasare,
  });
  final DateTime annaffiare;
  final DateTime potare;
  final DateTime travasare;

  @override
  State<MobileTask> createState() => _MobileTaskState();
}

class _MobileTaskState extends State<MobileTask> {
  @override
  Widget build(BuildContext context) {
    String annaffiareToString =
        "${widget.annaffiare.day}/${widget.annaffiare.month}/${widget.annaffiare.year}";
    String potareToString =
        "${widget.potare.day}/${widget.potare.month}/${widget.potare.year}";
    String travasareToString =
        "${widget.travasare.day}/${widget.travasare.month}/${widget.travasare.year}";
    return Column(
      children: [
        Row(children: [AppStyle.dropletEmojiMobile, Text(annaffiareToString)]),
        Row(children: [AppStyle.carpentrySawEmojiMobile, Text(potareToString)]),
        Row(
          children: [AppStyle.pottedPlantEmojiMobile, Text(travasareToString)],
        ),
      ],
    );
  }
}
