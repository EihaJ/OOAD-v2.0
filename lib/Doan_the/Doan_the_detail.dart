import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';
import '../Chung/Search_Widget.dart';
import '../Chung/floating_action_button.dart';
import '../database/database.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../Loading.dart';

import '../1.model/Doan_The_Detail_Model.dart';
import '../1.model/Doan_The_Model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoanTheDetail extends StatefulWidget {
  final DoanTheItem doanThe;
  DoanTheDetail({required this.doanThe});

  @override
  _DoanTheDetailState createState() => _DoanTheDetailState();
}

class _DoanTheDetailState extends State<DoanTheDetail> {
  var _maNVController = TextEditingController();
  var _tenNVController = TextEditingController();

  bool loading = true;
  DateTime? _flagNV;
  DateTime? _flagNR;
  List<DoanTheDetailItem> items = [];
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
    final items = await GetDoanTheDetailCollection.getDoanTheDetailItem(
        query, widget.doanThe.id!);

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
              floatingActionButton: CustomFloatingActionButton(
                flag: 5,
                para: widget.doanThe,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterDocked,
              appBar: Navigation(
                tittleText: widget.doanThe.tenDT ?? '', //nhan ten doan the,
                backgroundOpacity: 0,
                elevationHeight: 0,
              ),
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
                    child: customSearch(),
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
                                        'Tên Nhân Viên',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 22.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      width: 243,
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.blueAccent[200],
                                    ),
                                    Container(
                                      width: 136,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Quá trình',
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
                                      _maNVController.text = items[index].maNV!;
                                      _tenNVController.text =
                                          items[index].tenNV!;
                                      _flagNV = items[index].ngayVao!;
                                      _flagNR = items[index].ngayRa!;
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(height: 10),
                                              _customTile(
                                                containerWidth: 219,
                                                title: 'Mã Nhân Viên:',
                                                hintText: 'Eg:. 001',
                                                controller: _maNVController,
                                              ),
                                              SizedBox(height: 12),
                                              _customTile(
                                                containerWidth: 219,
                                                title: 'Tên Nhân Viên:',
                                                hintText: 'Eg:. Hà Văn Dương',
                                                controller: _tenNVController,
                                              ),
                                              SizedBox(height: 12),
                                              GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 7,
                                                    top: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffF5F5F5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.25),
                                                        blurRadius: 4,
                                                        offset: Offset(0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  height: 54,
                                                  width: 219,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Ngày Vào',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.8,
                                                        ),
                                                      ),
                                                      _flagNV != null
                                                          ? Text(
                                                              '${_flagNV!.day}/${_flagNV!.month}/${_flagNV!.year}')
                                                          : Text('XX/XX/XXXX'),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: _flagNV != null
                                                        ? _flagNV!
                                                        : DateTime.now(),
                                                    firstDate: DateTime(
                                                        DateTime.now().year -
                                                            20),
                                                    lastDate: DateTime(
                                                        DateTime.now().year +
                                                            20),
                                                  ).then((date) {
                                                    setState(() {
                                                      _flagNV = date;
                                                      print(_flagNV);
                                                    });
                                                  });
                                                },
                                              ),
                                              SizedBox(height: 12),
                                              GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 7,
                                                    top: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffF5F5F5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.25),
                                                        blurRadius: 4,
                                                        offset: Offset(0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  height: 54,
                                                  width: 219,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Ngày Ra',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.8,
                                                        ),
                                                      ),
                                                      _flagNR != null
                                                          ? Text(
                                                              '${_flagNR!.day}/${_flagNR!.month}/${_flagNR!.year}')
                                                          : Text('XX/XX/XXXX'),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: _flagNR != null
                                                        ? _flagNR!
                                                        : DateTime.now(),
                                                    firstDate: DateTime(
                                                        DateTime.now().year -
                                                            20),
                                                    lastDate: DateTime(
                                                        DateTime.now().year +
                                                            20),
                                                  ).then((date) {
                                                    setState(() {
                                                      _flagNR = date;
                                                      print(_flagNR);
                                                    });
                                                  });
                                                },
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
                                                        .doc(widget.doanThe.id)
                                                        .collection(
                                                            'doanTheDetailCollection')
                                                        .doc(items[index].id)
                                                        .update({
                                                      'maNV':
                                                          _maNVController.text,
                                                      'tenNV':
                                                          _tenNVController.text,
                                                      'ngayVao': _flagNV,
                                                      'ngayRa': _flagNR,
                                                    });
                                                    Navigator.popUntil(
                                                        context,
                                                        ModalRoute.withName(
                                                            '/'));
                                                    Navigator.pushNamed(
                                                        context, '/DoanThe');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DoanTheDetail(
                                                                doanThe: widget
                                                                    .doanThe),
                                                      ),
                                                    );
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
                                      collection
                                          .doc(widget.doanThe.id)
                                          .collection('doanTheDetailCollection')
                                          .doc(items[index].id)
                                          .delete();
                                      Navigator.popUntil(
                                          context, ModalRoute.withName('/'));
                                      Navigator.pushNamed(context, '/DoanThe');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DoanTheDetail(
                                              doanThe: widget.doanThe),
                                        ),
                                      );
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
                                              width: 243,
                                              alignment: Alignment.center,
                                              child: Text(
                                                items[index].tenNV!,
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
                                              width: 136,
                                              alignment: Alignment.center,
                                              child: customText(
                                                ngayvao: DateFormat(
                                                        'dd/MM/yyyy')
                                                    .format(
                                                        items[index].ngayVao!),
                                                ngayra: items[index].ngayRa !=
                                                        null
                                                    ? DateFormat('dd/MM/yyyy')
                                                        .format(items[index]
                                                            .ngayRa!)
                                                    : null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {},
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
                                      _maNVController.text = items[index].maNV!;
                                      _tenNVController.text =
                                          items[index].tenNV!;
                                      _flagNV = items[index].ngayVao!;
                                      _flagNR = items[index].ngayRa!;
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(height: 10),
                                              _customTile(
                                                containerWidth: 219,
                                                title: 'Mã Nhân Viên:',
                                                hintText: 'Eg:. 001',
                                                controller: _maNVController,
                                              ),
                                              SizedBox(height: 12),
                                              _customTile(
                                                containerWidth: 219,
                                                title: 'Tên Nhân Viên:',
                                                hintText: 'Eg:. Hà Văn Dương',
                                                controller: _tenNVController,
                                              ),
                                              SizedBox(height: 12),
                                              GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 7,
                                                    top: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffF5F5F5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.25),
                                                        blurRadius: 4,
                                                        offset: Offset(0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  height: 54,
                                                  width: 219,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Ngày Vào',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.8,
                                                        ),
                                                      ),
                                                      _flagNV != null
                                                          ? Text(
                                                              '${_flagNV!.day}/${_flagNV!.month}/${_flagNV!.year}')
                                                          : Text('XX/XX/XXXX'),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: _flagNV != null
                                                        ? _flagNV!
                                                        : DateTime.now(),
                                                    firstDate: DateTime(
                                                        DateTime.now().year -
                                                            20),
                                                    lastDate: DateTime(
                                                        DateTime.now().year +
                                                            20),
                                                  ).then((date) {
                                                    setState(() {
                                                      _flagNV = date;
                                                      print(_flagNV);
                                                    });
                                                  });
                                                },
                                              ),
                                              SizedBox(height: 12),
                                              GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 7,
                                                    top: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffF5F5F5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.25),
                                                        blurRadius: 4,
                                                        offset: Offset(0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  height: 54,
                                                  width: 219,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Ngày Ra',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.8,
                                                        ),
                                                      ),
                                                      _flagNR != null
                                                          ? Text(
                                                              '${_flagNR!.day}/${_flagNR!.month}/${_flagNR!.year}')
                                                          : Text('XX/XX/XXXX'),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: _flagNR != null
                                                        ? _flagNR!
                                                        : DateTime.now(),
                                                    firstDate: DateTime(
                                                        DateTime.now().year -
                                                            20),
                                                    lastDate: DateTime(
                                                        DateTime.now().year +
                                                            20),
                                                  ).then((date) {
                                                    setState(() {
                                                      _flagNR = date;
                                                      print(_flagNR);
                                                    });
                                                  });
                                                },
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
                                                        .doc(widget.doanThe.id)
                                                        .collection(
                                                            'doanTheDetailCollection')
                                                        .doc(items[index].id)
                                                        .update({
                                                      'maNV':
                                                          _maNVController.text,
                                                      'tenNV':
                                                          _tenNVController.text,
                                                      'ngayVao': _flagNV,
                                                      'ngayRa': _flagNR,
                                                    });
                                                    Navigator.popUntil(
                                                        context,
                                                        ModalRoute.withName(
                                                            '/'));
                                                    Navigator.pushNamed(
                                                        context, '/DoanThe');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DoanTheDetail(
                                                                doanThe: widget
                                                                    .doanThe),
                                                      ),
                                                    );
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
                                      collection
                                          .doc(widget.doanThe.id)
                                          .collection('doanTheDetailCollection')
                                          .doc(items[index].id)
                                          .delete();
                                      Navigator.popUntil(
                                          context, ModalRoute.withName('/'));
                                      Navigator.pushNamed(context, '/DoanThe');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DoanTheDetail(
                                              doanThe: widget.doanThe),
                                        ),
                                      );
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
                                              width: 243,
                                              alignment: Alignment.center,
                                              child: Text(
                                                items[index].tenNV!,
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
                                              width: 136,
                                              alignment: Alignment.center,
                                              child: customText(
                                                ngayvao: DateFormat(
                                                        'dd/MM/yyyy')
                                                    .format(
                                                        items[index].ngayVao!),
                                                ngayra: items[index].ngayRa !=
                                                        null
                                                    ? DateFormat('dd/MM/yyyy')
                                                        .format(items[index]
                                                            .ngayRa!)
                                                    : null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {},
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
                                  _maNVController.text = items[index].maNV!;
                                  _tenNVController.text = items[index].tenNV!;
                                  _flagNV = items[index].ngayVao!;
                                  _flagNR = items[index].ngayRa!;
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 10),
                                          _customTile(
                                            containerWidth: 219,
                                            title: 'Mã Nhân Viên:',
                                            hintText: 'Eg:. 001',
                                            controller: _maNVController,
                                          ),
                                          SizedBox(height: 12),
                                          _customTile(
                                            containerWidth: 219,
                                            title: 'Tên Nhân Viên:',
                                            hintText: 'Eg:. Hà Văn Dương',
                                            controller: _tenNVController,
                                          ),
                                          SizedBox(height: 12),
                                          GestureDetector(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                left: 7,
                                                top: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Color(0xffF5F5F5),
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              height: 54,
                                              width: 219,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Ngày Vào',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12.8,
                                                    ),
                                                  ),
                                                  _flagNV != null
                                                      ? Text(
                                                          '${_flagNV!.day}/${_flagNV!.month}/${_flagNV!.year}')
                                                      : Text('XX/XX/XXXX'),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              showDatePicker(
                                                context: context,
                                                initialDate: _flagNV != null
                                                    ? _flagNV!
                                                    : DateTime.now(),
                                                firstDate: DateTime(
                                                    DateTime.now().year - 20),
                                                lastDate: DateTime(
                                                    DateTime.now().year + 20),
                                              ).then((date) {
                                                setState(() {
                                                  _flagNV = date;
                                                  print(_flagNV);
                                                });
                                              });
                                            },
                                          ),
                                          SizedBox(height: 12),
                                          GestureDetector(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                left: 7,
                                                top: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Color(0xffF5F5F5),
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              height: 54,
                                              width: 219,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Ngày Ra',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12.8,
                                                    ),
                                                  ),
                                                  _flagNR != null
                                                      ? Text(
                                                          '${_flagNR!.day}/${_flagNR!.month}/${_flagNR!.year}')
                                                      : Text('XX/XX/XXXX'),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              showDatePicker(
                                                context: context,
                                                initialDate: _flagNR != null
                                                    ? _flagNR!
                                                    : DateTime.now(),
                                                firstDate: DateTime(
                                                    DateTime.now().year - 20),
                                                lastDate: DateTime(
                                                    DateTime.now().year + 20),
                                              ).then((date) {
                                                setState(() {
                                                  _flagNR = date;
                                                  print(_flagNR);
                                                });
                                              });
                                            },
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
                                                    .doc(widget.doanThe.id)
                                                    .collection(
                                                        'doanTheDetailCollection')
                                                    .doc(items[index].id)
                                                    .update({
                                                  'maNV': _maNVController.text,
                                                  'tenNV':
                                                      _tenNVController.text,
                                                  'ngayVao': _flagNV,
                                                  'ngayRa': _flagNR,
                                                });
                                                Navigator.popUntil(context,
                                                    ModalRoute.withName('/'));
                                                Navigator.pushNamed(
                                                    context, '/DoanThe');
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DoanTheDetail(
                                                            doanThe:
                                                                widget.doanThe),
                                                  ),
                                                );
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
                                  collection
                                      .doc(widget.doanThe.id)
                                      .collection('doanTheDetailCollection')
                                      .doc(items[index].id)
                                      .delete();
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/'));
                                  Navigator.pushNamed(context, '/DoanThe');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoanTheDetail(
                                          doanThe: widget.doanThe),
                                    ),
                                  );
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
                                          width: 243,
                                          alignment: Alignment.center,
                                          child: Text(
                                            items[index].tenNV!,
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
                                          width: 136,
                                          alignment: Alignment.center,
                                          child: customText(
                                            ngayvao: DateFormat('dd/MM/yyyy')
                                                .format(items[index].ngayVao!),
                                            ngayra: items[index].ngayRa != null
                                                ? DateFormat('dd/MM/yyyy')
                                                    .format(
                                                        items[index].ngayRa!)
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {},
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

  Widget customSearch() => SearchWidget(
        text: query,
        onChanged: searchItem,
      );
  Future searchItem(String query) async => debounce(() async {
        final items = await GetDoanTheDetailCollection.getDoanTheDetailItem(
            query, widget.doanThe.id ?? '');

        setState(() {
          this.query = query;
          this.items = items;
        });
      });
}

Widget customText({required String ngayvao, var ngayra}) {
  return Column(
    children: [
      Text(
        'Từ: ',
        style: TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.w400,
          fontSize: 12.8,
        ),
      ),
      Text(
        ngayvao,
        style: TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
      Text(
        'Đến: ',
        style: TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.w400,
          fontSize: 12.8,
        ),
      ),
      if (ngayra == '' || ngayra == null)
        Text(
          'XX/XX/XXXX',
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        )
      else
        Text(
          ngayra,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
    ],
  );
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
