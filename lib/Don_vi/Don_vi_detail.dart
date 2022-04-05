import 'package:ooad_project/1.model/Don_Vi_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ooad_project/Don_vi/Don_vi_detail_change.dart';
import '../Loading.dart';
import 'dart:async';

import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';

import '../1.model/Nhan_Vien_Model.dart';
import '../Nhan_vien/Nhan_vien_detail.dart';
import '../Chung/search_widget.dart';

import '../database/database.dart';
import 'package:flutter/material.dart';

class DonViDetail extends StatefulWidget {
  final DonViItem donVi;
  DonViDetail({required this.donVi});

  @override
  State<DonViDetail> createState() => _DonViDetailState();
}

class _DonViDetailState extends State<DonViDetail> {
  bool loading = true;
  List<NhanVienItem> items = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  Future init() async {
    final items = await GetNhanVienCollection.getNhanVienItemInDonVi(
        query, widget.donVi.maDV!);

    setState(() {
      loading = false;
      this.items = items;
    });
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 100),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: Navigation(
                tittleText: 'Quản lý Đơn Vị',
                backgroundOpacity: 0,
                elevationHeight: 0,
              ),
              drawer: CustomDrawer(),
              bottomNavigationBar: BottomNavigation(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/DonVi.png'),
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
                          widget.donVi.imageUrl == null ||
                                  widget.donVi.imageUrl == ''
                              ? Container(
                                  height: 176,
                                  width: 176,
                                  color: Color(0xffF5F5F5),
                                  child: Image(
                                    image: AssetImage('assets/NoImage.png'),
                                  ),
                                )
                              : Container(
                                  height: 176,
                                  width: 176,
                                  color: Color(0xffF5F5F5),
                                  child: Image(
                                    image: NetworkImage(widget.donVi.imageUrl!),
                                  ),
                                ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _CustomTextField(
                                width: 123,
                                title: 'Mã Đơn Vị',
                                text: widget.donVi.maDV ?? '',
                              ),
                              SizedBox(width: 10),
                              _CustomTextField(
                                width: 219,
                                height: 90,
                                title: 'Tên Đơn Vị',
                                text: widget.donVi.tenDV ?? '',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              _CustomTextField(
                                width: 171,
                                title: 'Số điện thoại',
                                text: widget.donVi.sdt ?? '',
                              ),
                              SizedBox(width: 10),
                              _CustomTextField(
                                width: 171,
                                title: 'Năm thành lập',
                                text: widget.donVi.namThanhLap.toString(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 3,
                              left: 7,
                            ),
                            alignment: Alignment.topLeft,
                            width: double.infinity,
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
                                customTitle('Địa chỉ'),
                                Row(
                                  children: [
                                    customTitle('Số: '),
                                    customText(
                                        widget.donVi.diaChi!.soNha ?? ''),
                                  ],
                                ),
                                Row(
                                  children: [
                                    customTitle('Phường: '),
                                    customText(
                                        widget.donVi.diaChi!.phuong ?? ''),
                                  ],
                                ),
                                Row(
                                  children: [
                                    customTitle('Quận: '),
                                    customText(widget.donVi.diaChi!.quan ?? ''),
                                  ],
                                ),
                                Row(
                                  children: [
                                    customTitle('Thành phố/Tỉnh: '),
                                    customText(widget.donVi.diaChi!.tp ?? ''),
                                  ],
                                ),
                              ],
                            ),
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
                                    padding:
                                        EdgeInsets.fromLTRB(20, 12, 20, 12),
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
                                          builder: (context) =>
                                              DonViDetailChange(
                                                  donVi: widget.donVi)),
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
                                    padding:
                                        EdgeInsets.fromLTRB(20, 12, 20, 12),
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
                                        .collection('donViCollection');
                                    collection
                                        .doc(widget.donVi.id ?? '')
                                        .delete();
                                    Navigator.popUntil(
                                        context, ModalRoute.withName('/'));
                                    Navigator.pushNamed(context, '/DonVi');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      alignment: Alignment(1, 0),
                      child: customSearch(),
                    ),
                    SizedBox(height: 10),
                    Column(children: [
                      for (int index = 0; index < items.length; index++)
                        if (index == 0)
                          Column(
                            children: [
                              Container(
                                width: 345,
                                height: 46,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff558FFF),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    topRight: Radius.circular(32),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Mã',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 22.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      width: 119,
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.blueAccent[200],
                                    ),
                                    Container(
                                      width: 223,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Tên Nhân Viên',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 22.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xff558FFF),
                                    ),
                                  ),
                                  width: 345,
                                  height: 117,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 119,
                                        alignment: Alignment.center,
                                        child: Text(
                                          items[index].maNV!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'HelveticaNeue',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        color: Colors.blueAccent[200],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 223,
                                        alignment: Alignment.center,
                                        child: Text(
                                          items[index].tenNV!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'HelveticaNeue',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NhanVienDetail(
                                          nhanVien: items[index]),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        else if (index == items.length - 1)
                          GestureDetector(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xff558FFF),
                                    ),
                                  ),
                                  width: 345,
                                  height: 117,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 119,
                                        alignment: Alignment.center,
                                        child: Text(
                                          items[index].maNV!,
                                          style: TextStyle(
                                            fontFamily: 'HelveticaNeue',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        color: Colors.blueAccent[200],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 223,
                                        alignment: Alignment.center,
                                        child: Text(
                                          items[index].tenNV!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'HelveticaNeue',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NhanVienDetail(nhanVien: items[index]),
                                ),
                              );
                            },
                          )
                        else
                          GestureDetector(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xff558FFF),
                                    ),
                                  ),
                                  width: 345,
                                  height: 117,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 119,
                                        alignment: Alignment.center,
                                        child: Text(
                                          items[index].maNV!,
                                          style: TextStyle(
                                            fontFamily: 'HelveticaNeue',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        color: Colors.blueAccent[200],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 223,
                                        alignment: Alignment.center,
                                        child: Text(
                                          items[index].tenNV!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'HelveticaNeue',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NhanVienDetail(nhanVien: items[index]),
                                ),
                              );
                            },
                          )
                    ]),
                  ],
                ),
              ),
            ),
          );
  }

  Widget customSearch() => SearchWidget(
        text: query,
        onChanged: searchItem,
      );
  Future searchItem(String query) async => debounce(() async {
        final items = await GetNhanVienCollection.getNhanVienItemInDonVi(
            query, widget.donVi.maDV!);

        setState(() {
          this.query = query;
          this.items = items;
        });
      });
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
