import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../1.model/Khen_Thuong_Model.dart';

class KhenThuongDetail extends StatefulWidget {
  final KhenThuongItem khenThuong;
  KhenThuongDetail({required this.khenThuong});

  @override
  State<KhenThuongDetail> createState() => _KhenThuongDetailState();
}

class _KhenThuongDetailState extends State<KhenThuongDetail> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          _CustomTextField(
            width: 219,
            title: 'Loại: ',
            text: widget.khenThuong.loai ?? '',
          ),
          SizedBox(height: 12),
          _CustomTextField(
            width: 219,
            title: 'Nội Dung: ',
            text: widget.khenThuong.noiDungKhenThuong ?? '',
          ),
          SizedBox(height: 12),
          _CustomTextField(
            width: 219,
            title: 'Cấp Độ: ',
            text: widget.khenThuong.capDoKhenThuong ?? '',
          ),
          SizedBox(height: 12),
          _CustomTextField(
            width: 219,
            title: 'Ngày nhận: ',
            text: DateFormat('dd/MM/yyyy')
                .format(widget.khenThuong.ngayKhenThuong!),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  double? height;
  final double width;
  final String title;
  final String text;

  _CustomTextField({
    this.height,
    required this.width,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 3,
        left: 7,
      ),
      height: height ?? 45,
      width: width,
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTitle(title),
          customText(text),
        ],
      ),
    );
  }
}

Widget customTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w400,
      fontSize: 12.8,
    ),
  );
}

Widget customText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
  );
}
