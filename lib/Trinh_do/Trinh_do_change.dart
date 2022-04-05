import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';

import '../1.model/Trinh_Do_Model.dart';

class TrinhDoChange extends StatefulWidget {
  final TrinhDoItem trinhDo;
  TrinhDoChange({required this.trinhDo});
  @override
  State<TrinhDoChange> createState() => _TrinhDoChangeState();
}

class _TrinhDoChangeState extends State<TrinhDoChange> {
  var _tenTDController = TextEditingController();
  var _maTDController = TextEditingController();
  var _phuCapController = TextEditingController();
  var _noiCapBangController = TextEditingController();
  var maCMController = TextEditingController();
  var tenCMController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _tenTDController.text = widget.trinhDo.tenTD ?? '';
    _maTDController.text = widget.trinhDo.maTD ?? '';
    _phuCapController.text = widget.trinhDo.phuCap.toString();
    _noiCapBangController.text = widget.trinhDo.noiCapBang ?? '';

    maCMController.text = widget.trinhDo.chuyenMon!.maCM ?? '';
    tenCMController.text = widget.trinhDo.chuyenMon!.tenCM ?? '';

    CollectionReference trinhDo =
        FirebaseFirestore.instance.collection('trinhDoCollection');
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navigation(
          tittleText: 'Quản lý Trình Độ',
          backgroundOpacity: 0,
          elevationHeight: 0,
        ),
        drawer: CustomDrawer(),
        bottomNavigationBar: BottomNavigation(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/TrinhDo.png'),
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

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
//Mã đơn vị
                        Column(
                          children: [
                            customTile(
                              controller: _maTDController,
                              containerWidth: 123,
                              title: 'Mã Trình Độ',
                              hintText: 'Eg:. 001',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            customTile(
                              controller: _phuCapController,
                              containerWidth: 123,
                              title: 'Phụ Cấp',
                              hintText: 'Eg:. 500000',
                            ),
                          ],
                        ),
//Mã đơn vị
                        SizedBox(
                          width: 10,
                        ),
// Tên Trình Độ

                        customTile(
                          controller: _tenTDController,
                          containerWidth: 219,
                          maxLines: 4,
                          height: 118,
                          title: 'Tên Trình Độ',
                          hintText: 'Eg:. IELTS',
                        ),
// Tên Trình Độ
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

//SĐT
                    customTile(
                      controller: _noiCapBangController,
                      containerWidth: double.infinity,
                      title: 'Nơi Cấp',
                      hintText: 'Eg:. Hội Đồng Anh',
                    ),
//SĐT

                    SizedBox(
                      height: 10,
                    ),
//Mã chuyên môn
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customTile(
                          controller: maCMController,
                          containerWidth: 123,
                          title: 'Mã Chuyên Môn',
                          hintText: 'Eg:. 001',
                        ),
//Mã chuyên môn
                        SizedBox(
                          width: 10,
                        ),
// Tên chuyên môn

                        customTile(
                          controller: tenCMController,
                          containerWidth: 219,
                          title: 'Tên Chuyên Môn',
                          hintText: 'Eg:. Tiếng Anh',
                        ),
                      ],
                    ),
// Tên chuyên môn

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
                          ChuyenMonItem chuyenMon = new ChuyenMonItem(
                            tenCM: tenCMController.text,
                            maCM: maCMController.text,
                          );

                          TrinhDoItem data = new TrinhDoItem(
                            maTD: _maTDController.text,
                            tenTD: _tenTDController.text,
                            noiCapBang: _noiCapBangController.text,
                            phuCap: int.tryParse(_phuCapController.text),
                            chuyenMon: chuyenMon,
                            id: widget.trinhDo.id,
                          );

                          trinhDo.doc(widget.trinhDo.id).update(data.toJson());

                          Navigator.popUntil(context, ModalRoute.withName('/'));
                          Navigator.pushNamed(context, '/TrinhDo');
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
