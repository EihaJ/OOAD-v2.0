import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ooad_project/Chung/image_changed.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Chung/image_changed.dart';
import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';

import '../1.model/Nhan_Vien_Model.dart';
import '../Nhan_vien/Nhan_vien.dart';

class NhanVienDetailChange extends StatefulWidget {
  final NhanVienItem nhanVien;
  NhanVienDetailChange({required this.nhanVien});
  @override
  State<NhanVienDetailChange> createState() => _NhanVienDetailChangeState();
}

class _NhanVienDetailChangeState extends State<NhanVienDetailChange> {
  Function(String?)? _soNhaOnChange;
  Function(String?)? _phuongOnChange;
  Function(String?)? _quanOnChange;
  Function(String?)? _tpOnChange;
  String imageUrl = '';

  var tenNVController = TextEditingController();
  var maNVController = TextEditingController();

  var gioiTinhController = TextEditingController();
  var danTocController = TextEditingController();
  var cMNDController = TextEditingController();

  var maDonViController = TextEditingController();
  var maNgachController = TextEditingController();

  var soNhaController = TextEditingController();
  var phuongController = TextEditingController();
  var quanController = TextEditingController();
  var tpController = TextEditingController();
  DateTime? _flagNV;
  DateTime? _flagNR;
  DateTime? _flagNS;

  @override
  Widget build(BuildContext context) {
    String imageUrl = '';

    tenNVController.text = widget.nhanVien.tenNV ?? '';
    maNVController.text = widget.nhanVien.maNV ?? '';

    _flagNV = widget.nhanVien.ngayVaoTruong;
    _flagNR = widget.nhanVien.ngayRaTruong;
    _flagNS = widget.nhanVien.ngaySinh;

    widget.nhanVien.gioiTinh == 1
        ? gioiTinhController.text = 'Nam'
        : widget.nhanVien.gioiTinh == 0
            ? gioiTinhController.text = 'Nữ'
            : gioiTinhController.text = '';

    danTocController.text = widget.nhanVien.danToc ?? '';
    cMNDController.text = widget.nhanVien.cMND ?? '';

    maDonViController.text = widget.nhanVien.maDonViQuanLi ?? '';
    maNgachController.text = widget.nhanVien.maNgach ?? '';

    soNhaController.text = widget.nhanVien.diaChi?.soNha ?? '';
    phuongController.text = widget.nhanVien.diaChi?.phuong ?? '';
    quanController.text = widget.nhanVien.diaChi?.quan ?? '';
    tpController.text = widget.nhanVien.diaChi?.tp ?? '';

    CollectionReference nhanVien =
        FirebaseFirestore.instance.collection('nhanVienCollection');
    return SafeArea(
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
                    const SizedBox(
                      height: 33,
                    ),
                    GestureDetector(
                      child: Container(
                        height: 176,
                        width: 176,
                        color: Color(0xffF5F5F5),
                        child: ImageChanged(
                          onFileChanged: (imageUrl) {
                            setState(
                              () {
                                this.imageUrl = imageUrl;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
//Mã đơn vị
                        customTile(
                          controller: maNVController,
                          containerWidth: 114,
                          title: 'Mã Nhân Viên:',
                          hintText: 'Eg:. 001',
                        ),
//Mã đơn vị
                        SizedBox(
                          width: 10,
                        ),
// Tên Nhân Viên

                        customTile(
                          controller: tenNVController,
                          containerWidth: 223,
                          maxLines: 3,
                          height: 90,
                          title: 'Tên Nhân Viên:',
                          hintText: 'Eg:. Hà Văn Dương',
                        ),
// Tên Nhân Viên
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(
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
                            height: 54,
                            width: 169,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ngày Sinh',
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.8,
                                  ),
                                ),
                                widget.nhanVien.ngaySinh != null
                                    ? Text(
                                        DateFormat('dd/MM/yyyy')
                                            .format(widget.nhanVien.ngaySinh!),
                                      )
                                    : Text('XX/XX/XXXX'),
                              ],
                            ),
                          ),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: widget.nhanVien.ngaySinh != null
                                  ? widget.nhanVien.ngaySinh!
                                  : DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 80),
                              lastDate: DateTime(DateTime.now().year + 1),
                            ).then(
                              (date) {
                                setState(() {
                                  widget.nhanVien.ngaySinh = date;
                                });
                              },
                            );
                          },
                        ),

                        SizedBox(
                          width: 10,
                        ),
//gioiTinh
                        customTile(
                          controller: gioiTinhController,
                          containerWidth: 82,
                          title: 'Giới tính:',
                          hintText: 'Eg:. Nam',
                        ),
//gioiTinh
                        SizedBox(
                          width: 10,
                        ),
// Năm sinh
                        customTile(
                          controller: danTocController,
                          containerWidth: 82,
                          title: 'Dân tộc:',
                          hintText: 'Eg:. Kinh',
                        ),
// Năm sinh
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
//Dia chi

                    Container(
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
                      height: 170,
                      width: 353,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTitle('Địa chỉ'),
                          Row(
                            children: [
                              customTitle('Số: '),
                              Flexible(
                                child: TextFormField(
                                  controller: soNhaController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Eg:. Khu phố 6',
                                    focusColor: Color(0xff224E99),
                                    hintStyle: TextStyle(color: Colors.black26),
                                    border: InputBorder.none,
                                  ),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
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
                                    _soNhaOnChange!(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              customTitle('Phường: '),
                              Flexible(
                                child: TextFormField(
                                  controller: phuongController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Eg:. Linh Trung',
                                    focusColor: Color(0xff224E99),
                                    hintStyle: TextStyle(color: Colors.black26),
                                    border: InputBorder.none,
                                  ),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
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
                                    _phuongOnChange!(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              customTitle('Quận: '),
                              Flexible(
                                child: TextFormField(
                                  controller: quanController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Eg:. Thủ Đức',
                                    focusColor: Color(0xff224E99),
                                    hintStyle: TextStyle(color: Colors.black26),
                                    border: InputBorder.none,
                                  ),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
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
                                    _quanOnChange!(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              customTitle('Thành phố/Tỉnh: '),
                              Flexible(
                                child: TextFormField(
                                  controller: tpController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Eg:. Hồ Chí Minh',
                                    focusColor: Color(0xff224E99),
                                    hintStyle: TextStyle(color: Colors.black26),
                                    border: InputBorder.none,
                                  ),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
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
                                    _tpOnChange!(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

//Dia chi

                    SizedBox(
                      height: 10,
                    ),
                    customTile(
                      controller: cMNDController,
                      containerWidth: 345,
                      title: 'CMND:',
                      hintText: 'Eg:. 079204019041',
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(
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
                            height: 54,
                            width: 167.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ngày Vào',
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.8,
                                  ),
                                ),
                                widget.nhanVien.ngayVaoTruong != null
                                    ? Text(
                                        DateFormat('dd/MM/yyyy').format(
                                            widget.nhanVien.ngayVaoTruong!),
                                      )
                                    : Text('XX/XX/XXXX'),
                              ],
                            ),
                          ),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: widget.nhanVien.ngayVaoTruong != null
                                  ? widget.nhanVien.ngayVaoTruong!
                                  : DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 80),
                              lastDate: DateTime(DateTime.now().year + 80),
                            ).then(
                              (date) {
                                setState(() {
                                  widget.nhanVien.ngayVaoTruong = date;
                                });
                              },
                            );
                          },
                        ),

                        SizedBox(
                          width: 10,
                        ),
//gioiTinh
                        GestureDetector(
                          child: Container(
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
                            height: 54,
                            width: 167.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ngày Ra',
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.8,
                                  ),
                                ),
                                widget.nhanVien.ngayRaTruong != null
                                    ? Text(
                                        DateFormat('dd/MM/yyyy').format(
                                            widget.nhanVien.ngayRaTruong!),
                                      )
                                    : Text('XX/XX/XXXX'),
                              ],
                            ),
                          ),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: widget.nhanVien.ngayRaTruong != null
                                  ? widget.nhanVien.ngayRaTruong!
                                  : DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 80),
                              lastDate: DateTime(DateTime.now().year + 80),
                            ).then(
                              (date) {
                                setState(() {
                                  widget.nhanVien.ngayRaTruong = date;
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customTile(
                          controller: maDonViController,
                          containerWidth: 167.5,
                          title: 'Mã Đơn Vị Quản Lí: ',
                          hintText: 'Eg:. 001',
                        ),

                        SizedBox(
                          width: 10,
                        ),
//gioiTinh
                        customTile(
                          controller: maNgachController,
                          containerWidth: 167.5,
                          title: 'Mã Ngạch: ',
                          hintText: 'Eg:. 01.003',
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
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
                          DiaChi diaChi = new DiaChi(
                            phuong: phuongController.text,
                            soNha: soNhaController.text,
                            quan: quanController.text,
                            tp: tpController.text,
                          );

                          NhanVienItem data = new NhanVienItem(
                            maNV: maNVController.text,
                            tenNV: tenNVController.text,
                            ngaySinh: widget.nhanVien.ngaySinh,
                            cMND: cMNDController.text,
                            gioiTinh: gioiTinhController.text
                                    .toLowerCase()
                                    .contains('nam')
                                ? 1
                                : gioiTinhController.text
                                        .toLowerCase()
                                        .contains('nữ')
                                    ? 0
                                    : null,
                            danToc: danTocController.text,
                            imageUrl: imageUrl,
                            ngayRaTruong: widget.nhanVien.ngayRaTruong,
                            ngayVaoTruong: widget.nhanVien.ngayVaoTruong,
                            diaChi: diaChi,
                            maDonViQuanLi: maDonViController.text,
                            maNgach: maNgachController.text,
                            id: widget.nhanVien.id,
                          );
                          print('_flagNR: $widget.nhanVien.ngayRaTruong');
                          nhanVien
                              .doc(widget.nhanVien.id)
                              .update(data.toJson());

                          Navigator.popUntil(context, ModalRoute.withName('/'));
                          Navigator.pushNamed(context, '/NhanVien');
                        },
                      ),
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

  Widget customTile({
    num? maxLines,
    double? height,
    required double containerWidth,
    required String title,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 3,
        left: 7,
      ),
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
      height: height ?? 54,
      width: containerWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTitle(title),
          Flexible(
            child: customText(
              controller: controller,
              hintText: hintText,
              maxLines: maxLines,
            ),
          ),
        ],
      ),
    );
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

  Widget customText({
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
}
