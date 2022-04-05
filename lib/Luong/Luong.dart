import 'package:ooad_project/1.model/Don_Vi_Model.dart';
import 'package:ooad_project/Don_vi/Don_vi_detail.dart';
import 'package:ooad_project/Luong/Luong_don_vi_detail.dart';
import 'dart:async';

import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';
import '../Chung/floating_action_button.dart';
import '../Chung/Search_Widget.dart';
import '../database/database.dart';

import '../1.model/Don_Vi_Model.dart';

import 'package:flutter/material.dart';

class Luong extends StatefulWidget {
  @override
  _LuongState createState() => _LuongState();
}

class _LuongState extends State<Luong> {
  List<DonViItem> donViItems = [];
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
    final donViItems = await GetDonViCollection.getDonViItem(query);

    setState(() => this.donViItems = donViItems);
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
          tittleText: 'Quản lý Lương',
          backgroundOpacity: 0,
          elevationHeight: 0,
        ),
        floatingActionButton: CustomFloatingActionButton(flag: 1),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        drawer: CustomDrawer(),
        body: Column(
          children: [
            Image(
              image: AssetImage('assets/Luong.png'),
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
                itemCount: donViItems.length,
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
                              Container(
                                width: 1,
                                color: Colors.blueAccent[200],
                              ),
                              Container(
                                width: 136,
                                alignment: Alignment.center,
                                child: Text(
                                  'Tổng Lương',
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
                                  padding: EdgeInsets.all(10),
                                  width: 243,
                                  alignment: Alignment.center,
                                  child: Text(
                                    donViItems[index].tenDV!,
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
                                  // child: Text(
                                  //   donViItems[index].tongLuong.toString(),
                                  //   style: TextStyle(
                                  //     fontFamily: 'HelveticaNeue',
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w400,
                                  //   ),
                                  // ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LuongDonVi(donVi: donViItems[index]),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  else if (index == donViItems.length - 1)
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
                                  padding: EdgeInsets.all(10),
                                  width: 243,
                                  alignment: Alignment.center,
                                  child: Text(
                                    donViItems[index].tenDV!,
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
                                  // child: Text(
                                  //   donViItems[index].tongLuong.toString(),
                                  //   style: TextStyle(
                                  //     fontFamily: 'HelveticaNeue',
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w400,
                                  //   ),
                                  // ),
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
                                LuongDonVi(donVi: donViItems[index]),
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
                                  padding: EdgeInsets.all(10),
                                  width: 243,
                                  alignment: Alignment.center,
                                  child: Text(
                                    donViItems[index].tenDV!,
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
                                  // child: Text(
                                  //   donViItems[index].tongLuong.toString(),
                                  //   style: TextStyle(
                                  //     fontFamily: 'HelveticaNeue',
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w400,
                                  //   ),
                                  // ),
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
                                LuongDonVi(donVi: donViItems[index]),
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
        final donViItems = await GetDonViCollection.getDonViItem(query);

        setState(() {
          this.query = query;
          this.donViItems = donViItems;
        });
      });
}
