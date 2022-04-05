import 'package:flutter/material.dart';

class Navigation extends StatelessWidget implements PreferredSizeWidget {
  final double elevationHeight;
  final double backgroundOpacity;
  final String tittleText;

  Navigation({
    required this.elevationHeight,
    required this.backgroundOpacity,
    required this.tittleText,
  });

  @override
  Size get preferredSize => Size.fromHeight(44);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Color(0xff7D8AFF).withOpacity(0.75),
      elevation: elevationHeight,
      titleSpacing: 0,
      backgroundColor: Color(0xff6691FF)
          .withOpacity(backgroundOpacity)
          .withBlue(255), //8FB5FF
      title: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Text(
          tittleText,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
