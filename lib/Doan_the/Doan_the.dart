import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';
import '../Chung/floating_action_button.dart';
import '../Chung/Search_Widget.dart';
import '../database/database.dart';
import 'dart:async';
import '../Loading.dart';

import '../1.model/Doan_The_Model.dart';
import '../Doan_the/Doan_the_detail.dart';

import 'package:flutter/material.dart';

class DoanThe extends StatefulWidget {
  @override
  _DoanTheState createState() => _DoanTheState();
}

class _DoanTheState extends State<DoanThe> {
  var _tenDTController = TextEditingController();
  var _maDTController = TextEditingController();

  bool loading = true;
  List<DoanTheItem> items = [];
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
    final items = await GetDoanTheCollection.getDoanTheItem(query);

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
                tittleText: 'Quản lý Đoàn Thể',
                backgroundOpacity: 0,
                elevationHeight: 0,
              ),
              floatingActionButton: CustomFloatingActionButton(flag: 4),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterDocked,
              drawer: CustomDrawer(),
              body: Column(
                children: [
                  Image(
                    image: AssetImage('assets/DoanThe.png'),
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    alignment: Alignment(1, 0),
                    child: _customSearch(),
                  ),
                  Flexible(
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
                                        'Tên Đoàn Thể',
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
                              Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    caption: 'Sửa',
                                    color: Colors.blueAccent[200],
                                    icon: Icons.build,
                                    onTap: () {
                                      _tenDTController.text =
                                          items[index].tenDT!;
                                      _maDTController.text = items[index].maDT!;
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(height: 10),
                                              _customTile(
                                                containerWidth: 219,
                                                title: 'Mã Đoàn Thể:',
                                                hintText: '001',
                                                controller: _maDTController,
                                              ),
                                              SizedBox(height: 12),
                                              _customTile(
                                                containerWidth: 219,
                                                title: 'Tên Đoàn Thể:',
                                                hintText: 'Đoàn Thanh Niên',
                                                controller: _tenDTController,
                                              ),
                                              SizedBox(height: 15),
                                              Container(
                                                width: 171,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.blueAccent[200],
                                                    elevation: 0,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20, 12, 20, 12),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Sửa dữ liệu',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'doanTheCollection')
                                                        .doc(items[index].id)
                                                        .update({
                                                      'maDT':
                                                          _maDTController.text,
                                                      'tenDT':
                                                          _tenDTController.text,
                                                    });
                                                    Navigator.popUntil(
                                                        context,
                                                        ModalRoute.withName(
                                                            '/'));
                                                    Navigator.pushNamed(
                                                        context, '/DoanThe');
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconSlideAction(
                                    caption: 'Xóa',
                                    color: Colors.red[400],
                                    icon: Icons.delete,
                                    onTap: () {
                                      var collection = FirebaseFirestore
                                          .instance
                                          .collection('doanTheCollection');
                                      collection.doc(items[index].id).delete();
                                      Navigator.popUntil(
                                          context, ModalRoute.withName('/'));
                                      Navigator.pushNamed(context, '/DoanThe');
                                    },
                                  )
                                ],
                                child: GestureDetector(
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
                                            items[index].maDT ?? '',
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
                                            items[index].tenDT ?? '',
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
                                        builder: (context) => DoanTheDetail(
                                            doanThe: items[index]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        else if (index == items.length - 1)
                          return Column(
                            children: [
                              Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    caption: 'Sửa',
                                    color: Colors.blueAccent[200],
                                    icon: Icons.build,
                                    onTap: () {
                                      _tenDTController.text =
                                          items[index].tenDT!;
                                      _maDTController.text = items[index].maDT!;
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(height: 10),
                                              _customTile(
                                                containerWidth: 219,
                                                title: 'Mã Đoàn Thể:',
                                                hintText: '001',
                                                controller: _maDTController,
                                              ),
                                              SizedBox(height: 12),
                                              _customTile(
                                                containerWidth: 219,
                                                title: 'Tên Đoàn Thể:',
                                                hintText: 'Đoàn Thanh Niên',
                                                controller: _tenDTController,
                                              ),
                                              SizedBox(height: 15),
                                              Container(
                                                width: 171,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.blueAccent[200],
                                                    elevation: 0,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20, 12, 20, 12),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Sửa dữ liệu',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'doanTheCollection')
                                                        .doc(items[index].id)
                                                        .update({
                                                      'maDT':
                                                          _maDTController.text,
                                                      'tenDT':
                                                          _tenDTController.text,
                                                    });
                                                    Navigator.popUntil(
                                                        context,
                                                        ModalRoute.withName(
                                                            '/'));
                                                    Navigator.pushNamed(
                                                        context, '/DoanThe');
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconSlideAction(
                                    caption: 'Xóa',
                                    color: Colors.red[400],
                                    icon: Icons.delete,
                                    onTap: () {
                                      var collection = FirebaseFirestore
                                          .instance
                                          .collection('doanTheCollection');
                                      collection.doc(items[index].id).delete();
                                      Navigator.popUntil(
                                          context, ModalRoute.withName('/'));
                                      Navigator.pushNamed(context, '/DoanThe');
                                    },
                                  )
                                ],
                                child: GestureDetector(
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
                                                items[index].maDT ?? '',
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
                                                items[index].tenDT ?? '',
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
                                        builder: (context) => DoanTheDetail(
                                            doanThe: items[index]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 75),
                            ],
                          );
                        else
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'Sửa',
                                color: Colors.blueAccent[200],
                                icon: Icons.build,
                                onTap: () {
                                  _tenDTController.text = items[index].tenDT!;
                                  _maDTController.text = items[index].maDT!;
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 10),
                                          _customTile(
                                            containerWidth: 219,
                                            title: 'Mã Đoàn Thể:',
                                            hintText: '001',
                                            controller: _maDTController,
                                          ),
                                          SizedBox(height: 12),
                                          _customTile(
                                            containerWidth: 219,
                                            title: 'Tên Đoàn Thể:',
                                            hintText: 'Đoàn Thanh Niên',
                                            controller: _tenDTController,
                                          ),
                                          SizedBox(height: 15),
                                          Container(
                                            width: 171,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.blueAccent[200],
                                                elevation: 0,
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 12, 20, 12),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
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
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        'doanTheCollection')
                                                    .doc(items[index].id)
                                                    .update({
                                                  'maDT': _maDTController.text,
                                                  'tenDT':
                                                      _tenDTController.text,
                                                });
                                                Navigator.popUntil(context,
                                                    ModalRoute.withName('/'));
                                                Navigator.pushNamed(
                                                    context, '/DoanThe');
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconSlideAction(
                                caption: 'Xóa',
                                color: Colors.red[400],
                                icon: Icons.delete,
                                onTap: () {
                                  var collection = FirebaseFirestore.instance
                                      .collection('doanTheCollection');
                                  collection.doc(items[index].id).delete();
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/'));
                                  Navigator.pushNamed(context, '/DoanThe');
                                },
                              )
                            ],
                            child: GestureDetector(
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
                                            items[index].maDT ?? '',
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
                                            items[index].tenDT ?? '',
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
                                        DoanTheDetail(doanThe: items[index]),
                                  ),
                                );
                              },
                            ),
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

  Widget _customSearch() => SearchWidget(
        text: query,
        onChanged: _searchItem,
      );
  Future _searchItem(String query) async => debounce(() async {
        final items = await GetDoanTheCollection.getDoanTheItem(query);

        setState(() {
          this.query = query;
          this.items = items;
        });
      });
}

Widget _customTile({
  num? maxLines,
  double? height,
  required double containerWidth,
  required String title,
  required String hintText,
  required TextEditingController controller,
}) {
  return Container(
    padding: EdgeInsets.only(
      left: 7,
      top: 5,
    ),
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
    height: height ?? 54,
    width: containerWidth,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customTitle(title),
        Flexible(
          child: _customText(
            controller: controller,
            hintText: hintText,
            maxLines: maxLines,
          ),
        ),
      ],
    ),
  );
}

Widget _customTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w400,
      fontSize: 12.8,
    ),
  );
}

Widget _customText({
  num? maxLines,
  var defaultMaxLines = 1,
  required TextEditingController controller,
  required String hintText,
  Function(String?)? onChange,
}) {
  return TextFormField(
    controller: controller,
    maxLines: maxLines ?? defaultMaxLines,
    decoration: InputDecoration(
      isDense: true,
      hintText: hintText,
      focusColor: Color(0xff224E99),
      hintStyle: TextStyle(color: Colors.black26),
      border: InputBorder.none,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Không được bỏ trống trường này';
      }
      return null;
    },
    style: TextStyle(
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    textInputAction: TextInputAction.done,
    onChanged: (value) {
      onChange!(value);
    },
  );
}
