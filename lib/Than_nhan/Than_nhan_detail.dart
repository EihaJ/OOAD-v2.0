import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';

import 'Than_nhan_change.dart';

import '../1.model/Than_Nhan_Model.dart';

class ThanNhanDetail extends StatefulWidget {
  final ThanNhanItem thanNhan;
  ThanNhanDetail({required this.thanNhan});

  @override
  State<ThanNhanDetail> createState() => _ThanNhanDetailState();
}

class _ThanNhanDetailState extends State<ThanNhanDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navigation(
          tittleText: 'Quản lý Thân Nhân',
          backgroundOpacity: 0,
          elevationHeight: 0,
        ),
        drawer: CustomDrawer(),
        bottomNavigationBar: BottomNavigation(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/ThanNhan.png'),
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 29,
                  right: 29,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 33,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CustomTextField(
                          width: 221,
                          title: 'Tên Thân Nhân',
                          text: widget.thanNhan.tenTN ?? '',
                        ),
                        SizedBox(width: 10),
                        _CustomTextField(
                          width: 114,
                          title: 'Mối Quan Hệ',
                          text: widget.thanNhan.moiQH ?? '',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        _CustomTextField(
                          width: 185,
                          title: 'Ngày Sinh',
                          text: widget.thanNhan.ngaySinh != null
                              ? DateFormat('dd/MM/yyyy')
                                  .format(widget.thanNhan.ngaySinh!)
                              : 'XX/XX/XXXX',
                        ),
                        SizedBox(width: 10),
                        _CustomTextField(
                          width: 150,
                          title: 'Nghề Nghiệp',
                          text: widget.thanNhan.ngheNghiep ?? '',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 171,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent[200],
                              elevation: 0,
                              padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              'Sửa dữ liệu',
                              style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ThanNhanChange(
                                        thanNhan: widget.thanNhan)),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 171,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red[400],
                              elevation: 0,
                              padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              'Xoá dữ liệu',
                              style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              var collection = FirebaseFirestore.instance
                                  .collection('thanNhanCollection');
                              collection.doc(widget.thanNhan.id ?? '').delete();
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/'));
                              Navigator.pushNamed(context, '/ThanNhan');
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
        borderRadius: BorderRadius.circular(7),
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
