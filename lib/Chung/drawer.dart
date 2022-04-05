import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff6691FF).withOpacity(0.7),
              Color(0xff8396FB),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 135,
              width: double.infinity,
              //color: Colors.black,
              alignment: Alignment(-0.8, 0.9),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontSize: 64,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ButtonDrawer(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/DonVi');
              },
              textButton: 'Quản lý Đơn Vị',
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 1.5,
                  width: 215,
                  color: Colors.white.withOpacity(0.65),
                ),
              ],
            ),
            SizedBox(height: 2.2),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 1.5,
                  width: 215,
                  color: Colors.white.withOpacity(0.65),
                ),
              ],
            ),
            SizedBox(height: 3),
            ButtonDrawer(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/DoanThe');
              },
              textButton: 'Quản lý Đoàn Thể',
            ),
            SizedBox(height: 15),
            Container(
              height: 3,
              width: double.infinity,
              color: Colors.white,
            ),
            SizedBox(height: 15),
            ButtonDrawer(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/ChucVu');
              },
              textButton: 'Quản lý Chức Vụ',
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 1.5,
                  width: 215,
                  color: Colors.white.withOpacity(0.65),
                ),
              ],
            ),
            SizedBox(height: 2.2),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 1.5,
                  width: 215,
                  color: Colors.white.withOpacity(0.65),
                ),
              ],
            ),
            SizedBox(height: 3),
            ButtonDrawer(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/TrinhDo');
              },
              textButton: 'Quản lý Trình Độ',
            ),
            SizedBox(height: 15),
            Container(
              height: 3,
              width: double.infinity,
              color: Colors.white,
            ),
            SizedBox(height: 15),
            ButtonDrawer(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/NhanVien');
              },
              textButton: 'Quản lý Nhân Viên',
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 1.5,
                  width: 215,
                  color: Colors.white.withOpacity(0.65),
                ),
              ],
            ),
            SizedBox(height: 2.2),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 1.5,
                  width: 215,
                  color: Colors.white.withOpacity(0.65),
                ),
              ],
            ),
            SizedBox(height: 3),
            ButtonDrawer(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/Luong');
              },
              textButton: 'Quản lý Lương',
            ),
            SizedBox(height: 15),
            Container(
              height: 3,
              width: double.infinity,
              color: Colors.white,
            ),
            SizedBox(height: 15),
            ButtonDrawer(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/ThanNhan');
              },
              textButton: 'Quản lý Thân Nhân',
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonDrawer extends StatelessWidget {
  ButtonDrawer({
    @required this.onPressed,
    @required this.textButton,
  });

  final onPressed, textButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          child: Container(
            width: double.infinity,
            //color: Colors.black,
            alignment: Alignment(-0.9, 0),
            child: Text(
              textButton,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                fontSize: 31.25,
                color: Color(0xffFFFFFF),
              ),
            ),
          ),
          onPressed: onPressed,
        ),
        SizedBox(height: 6),
      ],
    );
  }
}
