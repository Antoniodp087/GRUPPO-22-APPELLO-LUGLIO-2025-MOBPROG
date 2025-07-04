import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResponsiveBase extends StatefulWidget {
  const ResponsiveBase({super.key});

  @override
  State<ResponsiveBase> createState() => _ResponsiveBaseState();
}

class _ResponsiveBaseState extends State<ResponsiveBase> {
  //tab changer
  int _selectedIndex = 0;
  void _tabChanger(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 402) {
          return Placeholder(color: Colors.black);
          //return BottomNavBar(currentIndex: _selectedIndex, onTap: _tabChanger);
        } else {
          return Placeholder(color: Colors.green);
          //return SideNavBar(currentIndex: _selectedIndex, onTap: _tabChanger);
        }
      },
    );
  }
}
