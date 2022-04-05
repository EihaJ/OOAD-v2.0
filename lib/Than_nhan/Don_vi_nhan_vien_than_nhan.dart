import 'package:ooad_project/1.model/Don_Vi_Model.dart';
import 'dart:async';

import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';
import '../Chung/floating_action_button.dart';
import '../Chung/Search_Widget.dart';
import '../database/database.dart';

import '../1.model/Don_Vi_Model.dart';

import 'Nhan_vien_than_nhan.dart';

import 'package:flutter/material.dart';

class DonViThanNhan extends StatefulWidget {
  @override
  _DonViThanNhanState createState() => _DonViThanNhanState();
}

class _DonViThanNhanState extends State<DonViThanNhan> {
  List<DonViItem> items = [];
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
    final items = await GetDonViCollection.getDonViItem(query);

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
        extendBodyBehindAppBar: true,
        appBar: Navigation(
          tittleText: 'Quản lý Thân Nhân',
          backgroundOpacity: 0,
          elevationHeight: 0,
        ),
        drawer: CustomDrawer(),
        body: Column(
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
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  if (index == 0)
                    return Column(
                      children: [
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
                                alignment: Alignment.center,
                                child: Text(
                                  'Mã',
                                  style: TextStyle(
                                    fontFamily: 'HelveticalNeue',
                                    fontSize: 22.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                width: 136,
                              ),
                              Container(
                                width: 1,
                                color: Colors.blueAccent[200],
                              ),
                              Container(
                                width: 243,
                                alignment: Alignment.center,
                                child: Text(
                                  'Tên Đơn Vị',
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
                            width: 382,
                            height: 117,
                            child: Row(
                              children: [
                                Container(
                                  width: 136,
                                  alignment: Alignment.center,
                                  child: Text(
                                    items[index].maDV!,
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
                                  width: 243,
                                  alignment: Alignment.center,
                                  child: Text(
                                    items[index].tenDV!,
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
                                builder: (context) =>
                                    NhanVienThanNhan(donViTN: items[index]),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  else if (index == items.length - 1)
                    return GestureDetector(
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
                                  width: 136,
                                  alignment: Alignment.center,
                                  child: Text(
                                    items[index].maDV!,
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
                                  width: 243,
                                  alignment: Alignment.center,
                                  child: Text(
                                    items[index].tenDV!,
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
                          SizedBox(height: 75),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NhanVienThanNhan(donViTN: items[index]),
                          ),
                        );
                      },
                    );
                  else
                    return GestureDetector(
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
                                  width: 136,
                                  alignment: Alignment.center,
                                  child: Text(
                                    items[index].maDV!,
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
                                  width: 243,
                                  alignment: Alignment.center,
                                  child: Text(
                                    items[index].tenDV!,
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
                                NhanVienThanNhan(donViTN: items[index]),
                          ),
                        );
                      },
                    );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }

  Widget customSearch() => SearchWidget(
        text: query,
        onChanged: searchItem,
      );
  Future searchItem(String query) async => debounce(() async {
        final items = await GetDonViCollection.getDonViItem(query);

        setState(() {
          this.query = query;
          this.items = items;
        });
      });
}
