import 'package:flutter/material.dart';
import 'package:ooad_project/Ho_so.dart';

class BottomNavigation extends StatelessWidget {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      child: BottomNavigationBar(
        elevation: 10,
        currentIndex: currentIndex,
        onTap: (index) => currentIndex = index,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        selectedItemColor: Color(0xff000000),
        unselectedItemColor: Color(0xff000000),
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              padding: EdgeInsets.only(right: 25, top: 1),
              icon: Icon(
                Icons.home_outlined,
                size: 26,
              ),
              onPressed: () => Navigator.popUntil(
                context,
                ModalRoute.withName('/'),
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              padding: EdgeInsets.only(left: 25, top: 0.5),
              icon: Icon(
                Icons.person_outline,
                size: 26,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HoSo(),
                ),
              ),
            ),
            label: '',
          )
        ],
      ),
    );
  }
}
