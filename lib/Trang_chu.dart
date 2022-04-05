import 'package:ooad_project/Chung/drawer.dart';
import 'Chung/bottom_navigation.dart';
import 'Chung/navigation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TrangChu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navigation(
        elevationHeight: 15,
        backgroundOpacity: 0.65,
        tittleText: 'Trang Chủ',
      ),
      bottomNavigationBar: BottomNavigation(),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 177,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff6691FF).withOpacity(0.7),
                    Color(0xff7D8AFF).withOpacity(0.95),
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Text(
                    'WELCOME',
                    style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 64,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Duong Ha,',
                    style: TextStyle(
                      fontSize: 48.8,
                      color: Color(0xffFFFFFF),
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            ButtonTrangChu(
              onPressed: () => Navigator.pushNamed(context, '/DonVi'),
              textButton: 'Quản lý Đơn Vị',
              imageButton: 'assets/DonVi.png',
            ),
            ButtonTrangChu(
              onPressed: () => Navigator.pushNamed(context, '/ChucVu'),
              textButton: 'Quản lý Chức Vụ',
              imageButton: 'assets/ChucVu.png',
            ),
            ButtonTrangChu(
              onPressed: () => Navigator.pushNamed(context, '/DoanThe'),
              textButton: 'Quản lý Đoàn Thể',
              imageButton: 'assets/DoanThe.png',
            ),
            ButtonTrangChu(
              onPressed: () => Navigator.pushNamed(context, '/TrinhDo'),
              textButton: 'Quản lý Trình Độ',
              imageButton: 'assets/TrinhDo.png',
            ),
            ButtonTrangChu(
              onPressed: () => Navigator.pushNamed(context, '/ThanNhan'),
              textButton: 'Quản lý Thân Nhân',
              imageButton: 'assets/ThanNhan.png',
            ),
            ButtonTrangChu(
              onPressed: () => Navigator.pushNamed(context, '/NhanVien'),
              textButton: 'Quản lý Nhân Viên',
              imageButton: 'assets/NhanVien.png',
            ),
            ButtonTrangChu(
              onPressed: () => Navigator.pushNamed(context, '/Luong'),
              textButton: 'Quản lý Lương',
              imageButton: 'assets/Luong.png',
            ),
            SizedBox(height: 29),
          ],
        ),
      ),
    );
  }
}

class ButtonTrangChu extends StatelessWidget {
  ButtonTrangChu({
    @required this.onPressed,
    @required this.textButton,
    @required this.imageButton,
  });

  final onPressed, textButton, imageButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 26),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            alignment: Alignment(-0.88, -0.98),
            height: 120,
            width: 367,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageButton),
              ),
            ),
            child: Text(
              textButton,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                fontSize: 31.25,
                color: Color(0xff595959),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
