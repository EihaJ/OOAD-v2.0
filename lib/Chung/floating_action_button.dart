import 'package:flutter/material.dart';
import '../Don_vi/Don_vi_detail_add.dart';
import '../Chuc_vu/Chuc_vu_add.dart';
import '../Chuc_vu/Chuc_vu_detail_add.dart';
import '../Doan_the/Doan_the_add.dart';
import '../Doan_the/Doan_the_detail_add.dart';
import '../Nhan_vien/Nhan_vien_detail_add.dart';
import '../Trinh_do/Trinh_do_add.dart';
import '../Trinh_do/Trinh_do_detail_add.dart';
import '../Than_nhan/Than_nhan_add.dart';

class CustomFloatingActionButton extends StatelessWidget {
  var flag;
  var para;
  CustomFloatingActionButton({required this.flag, this.para});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      shadowColor: Colors.black.withOpacity(0.75),
      elevation: 4.5,
      child: GestureDetector(
        child: Container(
          // alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent[200],
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 48,
          ),
        ),
        onTap: () {
          switch (flag) {
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DonViDetailAdd()));
              break;

            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChucVuAdd()));
              break;
            // chuc vu

            case 3:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChucVuDetaillAdd(para)));
              break;
            //chuc vu detail
            case 4:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DoanTheAdd()));
              break;
            //Doan the

            case 5:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DoanTheDetaillAdd(para)));
              break;
            // Doan the detail

            case 6:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NhanVienDetailAdd()));
              break;

            //nhan vien
            case 7:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TrinhDoAdd()));
              break;
            // trinh do
            case 8:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TrinhDoDetaillAdd(para)));
              break;
            // trinh do detail

            case 9:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ThanNhanAdd(para)));
              break;
            //Than Nhan

          }
        },
      ),
    );
  }
}
