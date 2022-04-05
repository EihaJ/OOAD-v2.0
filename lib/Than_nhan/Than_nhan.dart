import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';
import '../Chung/floating_action_button.dart';
import '../Chung/search_widget.dart';
import '../database/database.dart';
import 'dart:async';

import '../1.model/Nhan_Vien_Model.dart';
import '../1.model/Than_Nhan_Model.dart';

import 'Than_nhan_detail.dart';

import 'package:flutter/material.dart';

class ThanNhan extends StatefulWidget {
  final NhanVienItem nhanVien;
  ThanNhan({required this.nhanVien});

  @override
  _ThanNhanState createState() => _ThanNhanState();
}

class _ThanNhanState extends State<ThanNhan> {
  List<ThanNhanItem> items = [];
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
    final items = await GetThanNhanCollection.getThanNhanItem(
        query, widget.nhanVien.maNV ?? '');

    setState(() => this.items = items);
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

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigation(),
        extendBodyBehindAppBar: true,
        appBar: Navigation(
          tittleText: 'Quản lý Nhân Viên',
          backgroundOpacity: 0,
          elevationHeight: 0,
        ),
        drawer: CustomDrawer(),
        floatingActionButton: CustomFloatingActionButton(
          flag: 9,
          para: widget.nhanVien,
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/ThanNhan.png'),
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                alignment: Alignment(1, 0),
                child: customSearch(),
              ),
              SizedBox(height: 25),
              Container(
                width: 382,
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
                      width: 243,
                      alignment: Alignment.center,
                      child: Text(
                        'Tên Thân Nhân',
                        style: TextStyle(
                          fontFamily: 'HelveticalNeue',
                          fontSize: 22.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      color: Colors.blueAccent[200],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Mối QH',
                        style: TextStyle(
                          fontFamily: 'HelveticalNeue',
                          fontSize: 22.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      width: 136,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  for (int index = 0; index < items.length; index++)
                    if (index == items.length - 1)
                      GestureDetector(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff558FFF),
                                ),
                              ),
                              width: 382,
                              height: 117,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: 243,
                                    alignment: Alignment.center,
                                    child: Text(
                                      items[index].tenTN!,
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
                                    width: 136,
                                    alignment: Alignment.center,
                                    child: Text(
                                      items[index].moiQH!,
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
                                  ThanNhanDetail(thanNhan: items[index]),
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
                              width: 382,
                              height: 117,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: 243,
                                    alignment: Alignment.center,
                                    child: Text(
                                      items[index].tenTN!,
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
                                    width: 136,
                                    alignment: Alignment.center,
                                    child: Text(
                                      items[index].moiQH!,
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
                                  ThanNhanDetail(thanNhan: items[index]),
                            ),
                          );
                        },
                      ),
                ],
              ),
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
        final items = await GetThanNhanCollection.getThanNhanItem(
            query, widget.nhanVien.maNV ?? '');

        setState(() {
          this.query = query;
          this.items = items;
        });
      });
}
