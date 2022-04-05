import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../1.model/Trinh_Do_Model.dart';
import 'Trinh_do_detail.dart';

import 'package:intl/intl.dart';

class TrinhDoDetaillAdd extends StatefulWidget {
  final TrinhDoItem trinhDo;
  TrinhDoDetaillAdd(this.trinhDo);
  @override
  _TrinhDoDetaillAddState createState() => _TrinhDoDetaillAddState();
}

class _TrinhDoDetaillAddState extends State<TrinhDoDetaillAdd> {
  var _maNVController = TextEditingController();
  var _tenNVController = TextEditingController();

  DateTime? _flagNV;
  DateTime? _flagNR;

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                    'Ngày Hiệu Lực',
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.8,
                    ),
                  ),
                  _flagNV != null
                      ? Text(
                          DateFormat('dd/MM/yyyy').format(_flagNV!),
                        )
                      : Text('XX/XX/XXXX'),
                ],
              ),
            ),
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 20),
                      lastDate: DateTime(DateTime.now().year + 20),
                      fieldHintText: 'Eg:. 03/11/2001')
                  .then((date) {
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
                    'Ngày Hết Hạn',
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.8,
                    ),
                  ),
                  _flagNR != null
                      ? Text(
                          DateFormat('dd/MM/yyyy').format(_flagNR!),
                        )
                      : Text('XX/XX/XXXX'),
                ],
              ),
            ),
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 20),
                      lastDate: DateTime(DateTime.now().year + 20),
                      fieldHintText: 'Eg:. 03/11/2001')
                  .then((date) {
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
                var trinhDoDetail = FirebaseFirestore.instance
                    .collection('trinhDoCollection')
                    .doc(widget.trinhDo.id)
                    .collection('trinhDoDetailCollection');
                String id = trinhDoDetail.doc().id;
                trinhDoDetail.doc(id).set({
                  'maNV': _maNVController.text,
                  'tenNV': _tenNVController.text,
                  'ngayVao': _flagNV,
                  'ngayRa': _flagNR,
                  'id': id,
                });
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/TrinhDo');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TrinhDoDetail(trinhDo: widget.trinhDo),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
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
