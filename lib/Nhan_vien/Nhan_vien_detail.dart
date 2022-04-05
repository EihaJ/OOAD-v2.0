//TODO: them bang luong nhan vien

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ooad_project/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../1.model/Don_Vi_Model.dart';
import '../1.model/Chuc_Vu_Model.dart';
import '../1.model/Chuc_Vu_Detail_Model.dart';
import '../1.model/Doan_The_Model.dart';
import '../1.model/Doan_The_Detail_Model.dart';
import '../1.model/Nhan_Vien_Model.dart';
import '../1.model/Trinh_Do_Model.dart';
import '../1.model/Trinh_Do_Detail_Model.dart';
import '../1.model/Than_Nhan_Model.dart';
import '../1.model/Khen_Thuong_Model.dart';

import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';
import '../Loading.dart';

import 'Nhan_vien_detail_change.dart';

import '../Khen_thuong/Khen_thuong_detail.dart';
import '../Trinh_do/Trinh_do_detail.dart';
import '../Doan_the/Doan_the_detail.dart';
import '../Chuc_vu/Chuc_vu_detail.dart';
import '../Than_nhan/Don_vi_nhan_vien_than_nhan.dart';

class NhanVienDetail extends StatefulWidget {
  final NhanVienItem nhanVien;
  NhanVienDetail({required this.nhanVien});

  @override
  State<NhanVienDetail> createState() => _NhanVienDetailState();
}

class _NhanVienDetailState extends State<NhanVienDetail> {
  String query = '';
  bool loading = true;
  List<DonViItem> donViItems = [];
  List<DoanTheItem> doanTheItems = [];
  List<List<DoanTheDetailItem>> doanTheDetailItems = [];
  List<ChucVuItem> chucVuItems = [];
  List<List<ChucVuDetailItem>> chucVuDetailItems = [];
  List<TrinhDoItem> trinhDoItems = [];
  List<List<TrinhDoDetailItem>> trinhDoDetailItems = [];
  List<ThanNhanItem> thanNhanItems = [];
  List<KhenThuongItem> khenThuongItems = [];

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    final donViItems = await GetDonViCollection.getDonViItem(query);
    final doanTheItems = await GetDoanTheCollection.getDoanTheItem(query);
    final trinhDoItems = await GetTrinhDoCollection.getTrinhDoItem(query);
    final thanNhanItems = await GetThanNhanCollection.getThanNhanItem(
        query, widget.nhanVien.maNV!);
    final khenThuongItems = await GetKhenThuongCollection.getKhenThuongItem(
        query, widget.nhanVien.maNV!);

    var doanTheDetailItems =
        List<List<DoanTheDetailItem>>.generate(doanTheItems.length, (_) => []);

    for (int i = 0; i < doanTheItems.length; i++) {
      doanTheDetailItems[i] =
          await GetDoanTheDetailCollection.getDoanTheDetailItem(
              query, doanTheItems[i].id!);
    }

    final chucVuItems = await GetChucVuCollection.getChucVuItem(query);

    var chucVuDetailItems =
        List<List<ChucVuDetailItem>>.generate(chucVuItems.length, (_) => []);

    for (int i = 0; i < chucVuItems.length; i++) {
      chucVuDetailItems[i] =
          await GetChucVuDetailCollection.getChucVuDetailItem(
              query, chucVuItems[i].id!);
    }

    var trinhDoDetailItems =
        List<List<TrinhDoDetailItem>>.generate(trinhDoItems.length, (_) => []);

    for (int i = 0; i < trinhDoItems.length; i++) {
      trinhDoDetailItems[i] =
          await GetTrinhDoDetailCollection.getTrinhDoDetailItem(
              query, trinhDoItems[i].id!);
    }
    setState(() {
      this.doanTheItems = doanTheItems;
      this.doanTheDetailItems = doanTheDetailItems;
      this.chucVuItems = chucVuItems;
      this.chucVuDetailItems = chucVuDetailItems;
      this.trinhDoItems = trinhDoItems;
      this.trinhDoDetailItems = trinhDoDetailItems;
      this.thanNhanItems = thanNhanItems;
      this.khenThuongItems = khenThuongItems;

      this.donViItems = donViItems;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: Navigation(
                tittleText: 'Quản lý Nhân Viên',
                backgroundOpacity: 0,
                elevationHeight: 0,
              ),
              drawer: CustomDrawer(),
              bottomNavigationBar: BottomNavigation(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/NhanVien.png'),
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
                          widget.nhanVien.imageUrl == null ||
                                  widget.nhanVien.imageUrl == ''
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
                                    image:
                                        NetworkImage(widget.nhanVien.imageUrl!),
                                  ),
                                ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Thong tin ca nhan
                              Text(
                                'Thông Tin Cá Nhân: ',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  //  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _CustomTextField(
                                    width: 114,
                                    title: 'Mã Nhân Viên',
                                    text: widget.nhanVien.maNV ?? '',
                                  ),
                                  SizedBox(width: 10),
                                  _CustomTextField(
                                    width: 221,
                                    title: 'Tên Nhân Viên',
                                    text: widget.nhanVien.tenNV ?? '',
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
                                    text: widget.nhanVien.ngaySinh != null
                                        ? DateFormat('dd/MM/yyyy')
                                            .format(widget.nhanVien.ngaySinh!)
                                        : 'XX/XX/XXXX',
                                  ),
                                  SizedBox(width: 10),
                                  _CustomTextField(
                                    width: 70,
                                    title: 'Giới tính',
                                    text: widget.nhanVien.gioiTinh == 1
                                        ? 'Nam'
                                        : widget.nhanVien.gioiTinh == 0
                                            ? 'Nữ'
                                            : '',
                                  ),
                                  SizedBox(width: 10),
                                  _CustomTextField(
                                    width: 70,
                                    title: 'Dân tộc',
                                    text: widget.nhanVien.danToc ?? '',
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
                                width: 345,
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
                                            widget.nhanVien.diaChi?.soNha ??
                                                ''),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        customTitle('Phường: '),
                                        customText(
                                            widget.nhanVien.diaChi?.phuong ??
                                                ''),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        customTitle('Quận: '),
                                        customText(
                                            widget.nhanVien.diaChi?.quan ?? ''),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        customTitle('Thành phố/Tỉnh: '),
                                        customText(
                                            widget.nhanVien.diaChi?.tp ?? ''),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _CustomTextField(
                                width: 345,
                                title: 'CMND',
                                text: widget.nhanVien.cMND ?? '',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  _CustomTextField(
                                    width: 168,
                                    title: 'Ngày Vào',
                                    text: widget.nhanVien.ngayVaoTruong != null
                                        ? DateFormat('dd/MM/yyyy').format(
                                            widget.nhanVien.ngayVaoTruong!)
                                        : 'XX/XX/XXXX',
                                  ),
                                  SizedBox(width: 10),
                                  _CustomTextField(
                                    width: 167,
                                    title: 'Ngày Ra',
                                    text: widget.nhanVien.ngayRaTruong != null
                                        ? DateFormat('dd/MM/yyyy').format(
                                            widget.nhanVien.ngayRaTruong!)
                                        : 'XX/XX/XXXX',
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
                                height: 45,
                                width: 345,
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
                                    customTitle('Đơn Vị Quản Lí'),
                                    for (int i = 0; i < donViItems.length; i++)
                                      if (donViItems[i].maDV ==
                                          widget.nhanVien.maDonViQuanLi)
                                        customText(donViItems[i].tenDV!),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 12,
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NhanVienDetailChange(
                                                      nhanVien:
                                                          widget.nhanVien)),
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
                                          borderRadius:
                                              BorderRadius.circular(25),
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
                                        var collection = FirebaseFirestore
                                            .instance
                                            .collection('nhanVienCollection');
                                        collection
                                            .doc(widget.nhanVien.id ?? '')
                                            .delete();
                                        Navigator.popUntil(
                                            context, ModalRoute.withName('/'));
                                        Navigator.pushNamed(
                                            context, '/NhanVien');
                                      },
                                    ),
                                  ),
                                ],
                              ),

// Thong tin ca nhan
//show Chuc Vu

                              SizedBox(
                                height: 30,
                              ),

                              Text(
                                'Quá Trình Công Tác: ',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  //  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
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
                                        'Tên Chức Vụ',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      width: 223,
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.blueAccent[200],
                                    ),
                                    Container(
                                      width: 119,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Quá Trình',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  for (int i = 0; i < chucVuItems.length; i++)
                                    for (int j = 0;
                                        j < chucVuDetailItems[i].length;
                                        j++)
                                      if (chucVuDetailItems[i][j].maNV ==
                                          widget.nhanVien.maNV)
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
                                                      width: 223,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        chucVuItems[i].tenCV!,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 1,
                                                      color: Colors
                                                          .blueAccent[200],
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      width: 119,
                                                      alignment:
                                                          Alignment.center,
                                                      child: _customText2(
                                                        ngayvao: DateFormat(
                                                                'dd/MM/yyyy')
                                                            .format(
                                                                chucVuDetailItems[
                                                                        i][j]
                                                                    .ngayVao!),
                                                        ngayra: chucVuDetailItems[
                                                                        i][j]
                                                                    .ngayRa !=
                                                                null
                                                            ? DateFormat(
                                                                    'dd/MM/yyyy')
                                                                .format(
                                                                    chucVuDetailItems[
                                                                            i][j]
                                                                        .ngayRa!)
                                                            : null,
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
                                                    ChucVuDetail(
                                                        chucVu: chucVuItems[i]),
                                              ),
                                            );
                                          },
                                        ),
                                ],
                              ),
// show Chuc Vu

//show Doan The

                              SizedBox(
                                height: 30,
                              ),

                              Text(
                                'Hoạt Động Đoàn Thể: ',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  //  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
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
                                        'Tên Đoàn Thể',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      width: 223,
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.blueAccent[200],
                                    ),
                                    Container(
                                      width: 119,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Quá Trình',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  for (int i = 0; i < doanTheItems.length; i++)
                                    for (int j = 0;
                                        j < doanTheDetailItems[i].length;
                                        j++)
                                      if (doanTheDetailItems[i][j].maNV ==
                                          widget.nhanVien.maNV)
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
                                                      width: 223,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        doanTheItems[i].tenDT!,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 1,
                                                      color: Colors
                                                          .blueAccent[200],
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      width: 119,
                                                      alignment:
                                                          Alignment.center,
                                                      child: _customText2(
                                                        ngayvao: DateFormat(
                                                                'dd/MM/yyyy')
                                                            .format(
                                                                doanTheDetailItems[
                                                                        i][j]
                                                                    .ngayVao!),
                                                        ngayra: doanTheDetailItems[
                                                                        i][j]
                                                                    .ngayRa !=
                                                                null
                                                            ? DateFormat(
                                                                    'dd/MM/yyyy')
                                                                .format(
                                                                    doanTheDetailItems[
                                                                            i][j]
                                                                        .ngayRa!)
                                                            : null,
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
                                                    DoanTheDetail(
                                                        doanThe:
                                                            doanTheItems[i]),
                                              ),
                                            );
                                          },
                                        ),
                                ],
                              ),
// show Doan The

//show TrinhDo

                              SizedBox(
                                height: 30,
                              ),

                              Text(
                                'Trình Độ: ',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  //  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
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
                                        'Tên Trình Độ',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      width: 223,
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.blueAccent[200],
                                    ),
                                    Container(
                                      width: 119,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Hiệu lực',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  for (int i = 0; i < trinhDoItems.length; i++)
                                    for (int j = 0;
                                        j < trinhDoDetailItems[i].length;
                                        j++)
                                      if (trinhDoDetailItems[i][j].maNV ==
                                          widget.nhanVien.maNV)
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
                                                      width: 223,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        trinhDoItems[i].tenTD!,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 1,
                                                      color: Colors
                                                          .blueAccent[200],
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      width: 119,
                                                      alignment:
                                                          Alignment.center,
                                                      child: _customText2(
                                                        ngayvao: DateFormat(
                                                                'dd/MM/yyyy')
                                                            .format(
                                                                trinhDoDetailItems[
                                                                        i][j]
                                                                    .ngayVao!),
                                                        ngayra: trinhDoDetailItems[
                                                                        i][j]
                                                                    .ngayRa !=
                                                                null
                                                            ? DateFormat(
                                                                    'dd/MM/yyyy')
                                                                .format(
                                                                    trinhDoDetailItems[
                                                                            i][j]
                                                                        .ngayRa!)
                                                            : null,
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
                                                    TrinhDoDetail(
                                                        trinhDo:
                                                            trinhDoItems[i]),
                                              ),
                                            );
                                          },
                                        ),
                                ],
                              ),
// show Trinh Do

// show Than Nhan
                              SizedBox(
                                height: 30,
                              ),

                              Text(
                                'Thân Nhân: ',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  //  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
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
                                        'Tên Thân Nhân',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      width: 223,
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.blueAccent[200],
                                    ),
                                    Container(
                                      width: 119,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Mối QH',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  for (int i = 0; i < thanNhanItems.length; i++)
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
                                                  width: 223,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    thanNhanItems[i].tenTN!,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 1,
                                                  color: Colors.blueAccent[200],
                                                ),
                                                Container(
                                                  width: 119,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    thanNhanItems[i].moiQH!,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                DonViThanNhan(),
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
// show Than Nhan

// show khen thuong
                              SizedBox(
                                height: 30,
                              ),

                              Row(
                                children: [
                                  Text(
                                    'Khen Thưởng và Kỷ Luật: ',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      //  fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blueAccent[200],
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: Text(
                                        'Thêm dữ liệu',
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      onPressed: () {
                                        var _capDoController =
                                            TextEditingController();
                                        var _noiDungController =
                                            TextEditingController();
                                        var _loaiController =
                                            TextEditingController();
                                        DateTime? _flagKT;
                                        showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(height: 10),
                                                _customTile(
                                                  containerWidth: 219,
                                                  title: 'Loại:',
                                                  hintText: 'Khen Thưởng',
                                                  controller: _loaiController,
                                                ),
                                                SizedBox(height: 12),
                                                _customTile(
                                                  containerWidth: 219,
                                                  title: 'Nội Dung:',
                                                  hintText: 'Giảng Viên Giỏi',
                                                  controller:
                                                      _noiDungController,
                                                ),
                                                SizedBox(height: 12),
                                                _customTile(
                                                  containerWidth: 219,
                                                  title: 'Cấp Độ:',
                                                  hintText: 'Chủ Tịch Nước',
                                                  controller: _capDoController,
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
                                                              .withOpacity(
                                                                  0.25),
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
                                                          'Ngày Nhận',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'HelveticaNeue',
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 12.8,
                                                          ),
                                                        ),
                                                        _flagKT != null
                                                            ? Text(
                                                                DateFormat(
                                                                        'dd/MM/yyyy')
                                                                    .format(
                                                                        _flagKT!),
                                                              )
                                                            : Text(
                                                                'XX/XX/XXXX'),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          _flagKT != null
                                                              ? _flagKT!
                                                              : DateTime.now(),
                                                      firstDate: DateTime(
                                                          DateTime.now().year -
                                                              20),
                                                      lastDate: DateTime(
                                                          DateTime.now().year +
                                                              20),
                                                    ).then((date) {
                                                      setState(() {
                                                        _flagKT = date;
                                                        print(_flagKT);
                                                      });
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 15),
                                                Container(
                                                  width: 171,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors
                                                          .blueAccent[200],
                                                      elevation: 0,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20, 12, 20, 12),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Thêm dữ liệu',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'HelveticaNeue',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      String id = FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'khenThuongCollection')
                                                          .doc()
                                                          .id;
                                                      KhenThuongItem data =
                                                          new KhenThuongItem(
                                                        maNV: widget
                                                            .nhanVien.maNV,
                                                        capDoKhenThuong:
                                                            _capDoController
                                                                .text,
                                                        noiDungKhenThuong:
                                                            _noiDungController
                                                                .text,
                                                        loai: _loaiController
                                                            .text,
                                                        ngayKhenThuong: _flagKT,
                                                        id: id,
                                                      );

                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'khenThuongCollection')
                                                          .doc(id)
                                                          .set(data.toJson());

                                                      Navigator.popUntil(
                                                          context,
                                                          ModalRoute.withName(
                                                              '/'));
                                                      Navigator.pushNamed(
                                                          context, '/NhanVien');
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
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1,
                              ),
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
                                        'Nội Dung',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      width: 223,
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.blueAccent[200],
                                    ),
                                    Container(
                                      width: 119,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Loại',
                                        style: TextStyle(
                                          fontFamily: 'HelveticalNeue',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  for (int index = 0;
                                      index < khenThuongItems.length;
                                      index++)
                                    if (khenThuongItems[index].maNV ==
                                        widget.nhanVien.maNV)
                                      Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        secondaryActions: <Widget>[
                                          IconSlideAction(
                                            caption: 'Sửa',
                                            color: Colors.blueAccent[200],
                                            icon: Icons.build,
                                            onTap: () {
                                              var _capDoController =
                                                  TextEditingController();
                                              var _noiDungController =
                                                  TextEditingController();
                                              var _loaiController =
                                                  TextEditingController();
                                              DateTime? _flagKT;
                                              _noiDungController.text =
                                                  khenThuongItems[index]
                                                          .noiDungKhenThuong ??
                                                      '';
                                              _loaiController.text =
                                                  khenThuongItems[index].loai ??
                                                      '';
                                              _capDoController.text =
                                                  khenThuongItems[index]
                                                          .capDoKhenThuong ??
                                                      '';

                                              _flagKT = khenThuongItems[index]
                                                  .ngayKhenThuong;

                                              showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(height: 10),
                                                      _customTile(
                                                        containerWidth: 219,
                                                        title: 'Loại:',
                                                        hintText: 'Khen Thưởng',
                                                        controller:
                                                            _loaiController,
                                                      ),
                                                      SizedBox(height: 12),
                                                      _customTile(
                                                        containerWidth: 219,
                                                        title: 'Nội Dung:',
                                                        hintText:
                                                            'Giảng Viên Giỏi',
                                                        controller:
                                                            _noiDungController,
                                                      ),
                                                      SizedBox(height: 12),
                                                      _customTile(
                                                        containerWidth: 219,
                                                        title: 'Cấp Độ: ',
                                                        hintText:
                                                            'Chủ Tịch Nước',
                                                        controller:
                                                            _capDoController,
                                                      ),
                                                      SizedBox(height: 12),
                                                      GestureDetector(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 7,
                                                            top: 5,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xffF5F5F5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.25),
                                                                blurRadius: 4,
                                                                offset: Offset(
                                                                    0, 4),
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
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'HelveticaNeue',
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontSize:
                                                                      12.8,
                                                                ),
                                                              ),
                                                              _flagKT != null
                                                                  ? Text(
                                                                      DateFormat(
                                                                              'dd/MM/yyyy')
                                                                          .format(
                                                                              _flagKT!),
                                                                    )
                                                                  : Text(
                                                                      'XX/XX/XXXX'),
                                                            ],
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                _flagKT != null
                                                                    ? _flagKT!
                                                                    : DateTime
                                                                        .now(),
                                                            firstDate: DateTime(
                                                                DateTime.now()
                                                                        .year -
                                                                    20),
                                                            lastDate: DateTime(
                                                                DateTime.now()
                                                                        .year +
                                                                    20),
                                                          ).then((date) {
                                                            setState(() {
                                                              _flagKT = date;
                                                              print(_flagKT);
                                                            });
                                                          });
                                                        },
                                                      ),
                                                      SizedBox(height: 15),
                                                      Container(
                                                        width: 171,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors
                                                                    .blueAccent[
                                                                200],
                                                            elevation: 0,
                                                            padding: EdgeInsets
                                                                .fromLTRB(20,
                                                                    12, 20, 12),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'Sửa dữ liệu',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'HelveticaNeue',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            KhenThuongItem
                                                                data =
                                                                new KhenThuongItem(
                                                              maNV: widget
                                                                  .nhanVien
                                                                  .maNV,
                                                              capDoKhenThuong:
                                                                  _capDoController
                                                                      .text,
                                                              noiDungKhenThuong:
                                                                  _noiDungController
                                                                      .text,
                                                              loai:
                                                                  _loaiController
                                                                      .text,
                                                              ngayKhenThuong:
                                                                  _flagKT,
                                                              id: khenThuongItems[
                                                                      index]
                                                                  .id,
                                                            );

                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'khenThuongCollection')
                                                                .doc(khenThuongItems[
                                                                        index]
                                                                    .id)
                                                                .update(data
                                                                    .toJson());

                                                            Navigator.popUntil(
                                                                context,
                                                                ModalRoute
                                                                    .withName(
                                                                        '/'));
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/NhanVien');
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
                                                  .collection(
                                                      'khenThuongCollection');
                                              collection
                                                  .doc(
                                                      khenThuongItems[index].id)
                                                  .delete();
                                              Navigator.popUntil(context,
                                                  ModalRoute.withName('/'));
                                              Navigator.pushNamed(
                                                  context, '/NhanVien');
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
                                                width: 345,
                                                height: 117,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 223,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        khenThuongItems[index]
                                                            .noiDungKhenThuong!,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 1,
                                                      color: Colors
                                                          .blueAccent[200],
                                                    ),
                                                    Container(
                                                      width: 119,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        khenThuongItems[index]
                                                            .loai!,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                                    KhenThuongDetail(
                                                        khenThuong:
                                                            khenThuongItems[
                                                                index]),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                ],
                              ),

// show khen thuong

                              SizedBox(
                                height: 20,
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

Widget _customText2({String? ngayvao, var ngayra}) {
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
        ngayvao ?? 'XX/XX/XXXX',
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
