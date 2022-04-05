// chua doi flag de switch case
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../1.model/Than_Nhan_Model.dart';

class ThanNhanChange extends StatefulWidget {
  final ThanNhanItem thanNhan;
  ThanNhanChange({required this.thanNhan});

  @override
  State<ThanNhanChange> createState() => _ThanNhanChangeState();
}

class _ThanNhanChangeState extends State<ThanNhanChange> {
  var tenTNController = TextEditingController();
  var maNVController = TextEditingController();
  var ngheNghiepController = TextEditingController();
  var moiQHController = TextEditingController();

  DateTime? _flagNS;
  @override
  Widget build(BuildContext context) {
    CollectionReference thanNhan =
        FirebaseFirestore.instance.collection('thanNhanCollection');

    tenTNController.text = widget.thanNhan.tenTN ?? '';
    maNVController.text = widget.thanNhan.maNV ?? '';
    ngheNghiepController.text = widget.thanNhan.ngheNghiep ?? '';
    moiQHController.text = widget.thanNhan.moiQH ?? '';
    _flagNS = widget.thanNhan.ngaySinh;

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),

// Tên Đơn Vị

          customTile(
            controller: tenTNController,
            containerWidth: 219,
            title: 'Tên Thân Nhân',
            hintText: 'Eg:. Eiha Jewitt',
          ),
          SizedBox(
            height: 12,
          ),
// Tên Đơn Vị
          customTile(
            controller: moiQHController,
            containerWidth: 219,
            title: 'Mối Quan Hệ',
            hintText: 'Eg:. Con',
          ),
          SizedBox(
            height: 12,
          ),
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
              width: 219,
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
                  _flagNS != null
                      ? Text(
                          DateFormat('dd/MM/yyyy').format(_flagNS!),
                        )
                      : Text('XX/XX/XXXX'),
                ],
              ),
            ),
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: _flagNS != null ? _flagNS! : DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 80),
                lastDate: DateTime(DateTime.now().year + 20),
              ).then((date) {
                setState(() {
                  _flagNS = date;
                  print(_flagNS);
                });
              });
            },
          ),
          SizedBox(
            height: 12,
          ),
          customTile(
            controller: ngheNghiepController,
            containerWidth: 219,
            title: 'Nghề Nghiệp',
            hintText: 'Eg:. Joke-er',
          ),

          SizedBox(
            height: 15,
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
                ThanNhanItem data = new ThanNhanItem(
                  maNV: maNVController.text,
                  tenTN: tenTNController.text,
                  moiQH: moiQHController.text,
                  ngheNghiep: ngheNghiepController.text,
                  ngaySinh: _flagNS,
                  id: widget.thanNhan.id,
                );
                thanNhan.doc(widget.thanNhan.id).update(data.toJson());

                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/ThanNhan');
              },
            ),
          ),
          SizedBox(height: 10),
        ],
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
