import 'dart:async';

import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';
import '../Chung/floating_action_button.dart';
import '../Chung/Search_Widget.dart';
import '../database/database.dart';
import '../Loading.dart';

import '../1.model/Trinh_Do_Model.dart';
import 'Trinh_do_detail.dart';

import 'package:flutter/material.dart';

class TrinhDo extends StatefulWidget {
  @override
  _TrinhDoState createState() => _TrinhDoState();
}

class _TrinhDoState extends State<TrinhDo> {
  bool loading = true;
  List<TrinhDoItem> items = [];
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
    final items = await GetTrinhDoCollection.getTrinhDoItem(query);

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

  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: Navigation(
                tittleText: 'Quản lý Trình Độ',
                backgroundOpacity: 0,
                elevationHeight: 0,
              ),
              floatingActionButton: CustomFloatingActionButton(flag: 7),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterDocked,
              drawer: CustomDrawer(),
              body: Column(
                children: [
                  Image(
                    image: AssetImage('assets/TrinhDo.png'),
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
                                        'Tên Trình Độ',
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
                                          items[index].maTD!,
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
                                          items[index].tenTD!,
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
                                          TrinhDoDetail(trinhDo: items[index]),
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
                                          items[index].maTD!,
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
                                          items[index].tenTD!,
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
                                      TrinhDoDetail(trinhDo: items[index]),
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
                                          items[index].maTD!,
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
                                          items[index].tenTD!,
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
                                      TrinhDoDetail(trinhDo: items[index]),
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
        final items = await GetTrinhDoCollection.getTrinhDoItem(query);

        setState(() {
          this.query = query;
          this.items = items;
        });
      });
}
