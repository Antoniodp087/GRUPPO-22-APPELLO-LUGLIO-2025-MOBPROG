import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class Task extends StatefulWidget {
  const Task({
    super.key,
    required this.annaffiare,
    required this.potare,
    required this.travasare,
  });
  final DateTime annaffiare;
  final DateTime potare;
  final DateTime travasare;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
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
        Row(children: [AppStyle.dropletEmoji, Text(annaffiareToString)]),
        Row(children: [AppStyle.carpentrySawEmoji, Text(potareToString)]),
        Row(children: [AppStyle.pottedPlantEmoji, Text(travasareToString)]),
      ],
    );
  }
}
