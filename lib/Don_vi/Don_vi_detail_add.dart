import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ooad_project/Chung/image_changed.dart';
import 'package:flutter/material.dart';

import '../Chung/image_changed.dart';
import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';

import '../1.model/Don_Vi_Model.dart';
import '../Don_vi/Don_vi.dart';

class DonViDetailAdd extends StatefulWidget {
  @override
  State<DonViDetailAdd> createState() => _DonViDetailAddState();
}

class _DonViDetailAddState extends State<DonViDetailAdd> {
  Function(String?)? _soNhaOnChange;
  Function(String?)? _phuongOnChange;
  Function(String?)? _quanOnChange;
  Function(String?)? _tpOnChange;
  String imageUrl = '';
  var _tenDVController = TextEditingController();
  var _maDVController = TextEditingController();
  var _namThanhLapController = TextEditingController();
  var _sdtController = TextEditingController();
  var soNhaController = TextEditingController();
  var phuongController = TextEditingController();
  var quanController = TextEditingController();
  var tpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference donVi =
        FirebaseFirestore.instance.collection('donViCollection');
    return SafeArea(
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
                          controller: _maDVController,
                          containerWidth: 123,
                          title: 'Mã Đơn Vị',
                          hintText: 'Eg:. SE',
                        ),
//Mã đơn vị
                        SizedBox(
                          width: 10,
                        ),
// Tên Đơn Vị

                        customTile(
                          controller: _tenDVController,
                          containerWidth: 219,
                          maxLines: 3,
                          height: 90,
                          title: 'Tên Đơn Vị',
                          hintText: 'Eg:. Khoa Công nghệ phần mềm',
                        ),
// Tên Đơn Vị
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
//SĐT
                        customTile(
                          controller: _sdtController,
                          containerWidth: 172,
                          title: 'Số điện thoại',
                          hintText: 'Eg:. 0911902093',
                        ),
//SĐT
                        SizedBox(
                          width: 10,
                        ),
// Năm TL
                        customTile(
                          controller: _namThanhLapController,
                          containerWidth: 171,
                          title: 'Năm thành lập',
                          hintText: 'Eg:. 2001',
                        ),
// Năm TL
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
                        borderRadius: BorderRadius.circular(7),
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
                          'Thêm dữ liệu',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          String id = donVi.doc().id;
                          DiaChi diaChi = new DiaChi(
                            phuong: phuongController.text,
                            soNha: soNhaController.text,
                            quan: quanController.text,
                            tp: tpController.text,
                          );

                          DonViItem data = new DonViItem(
                            maDV: _maDVController.text,
                            tenDV: _tenDVController.text,
                            sdt: _sdtController.text,
                            namThanhLap: _namThanhLapController.text,
                            imageUrl: imageUrl,
                            diaChi: diaChi,
                            id: id,
                          );

                          donVi.doc(id).set(data.toJson());

                          Navigator.popUntil(context, ModalRoute.withName('/'));
                          Navigator.pushNamed(context, '/DonVi');
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
