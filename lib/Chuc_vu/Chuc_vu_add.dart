import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChucVuAdd extends StatefulWidget {
  @override
  State<ChucVuAdd> createState() => _ChucVuAddState();
}

class _ChucVuAddState extends State<ChucVuAdd> {
  var tenCVController = TextEditingController();
  var maCVController = TextEditingController();
  var heSoController = TextEditingController();
  var namController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference chucVu =
        FirebaseFirestore.instance.collection('chucVuCollection');
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
//Mã đơn vị
          customTile(
            controller: maCVController,
            containerWidth: 219,
            title: 'Mã Chức Vụ',
            hintText: 'Eg:. 001',
          ),
//Mã đơn vị
          SizedBox(
            height: 12,
          ),
// Tên Đơn Vị

          customTile(
            controller: tenCVController,
            containerWidth: 219,
            title: 'Tên Chức Vụ',
            hintText: 'Eg:. CEO',
          ),
//           SizedBox(
//             height: 12,
//           ),
// // Tên Đơn Vị
//           customTile(
//             controller: namController,
//             containerWidth: 219,
//             title: 'Năm',
//             hintText: 'Eg:. 2021',
//           ),
          SizedBox(
            height: 12,
          ),
          customTile(
            controller: heSoController,
            containerWidth: 219,
            title: 'Hệ Số',
            hintText: 'Eg:. 0.4',
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
                'Thêm dữ liệu',
                style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                String id = chucVu.doc().id;
                chucVu.doc(id).set({
                  'tenCV': tenCVController.text,
                  'maCV': maCVController.text,
                  'id': id,
                  'heSo': int.tryParse(heSoController.text),
                });

                // String? id2 = namController.text;

                // chucVu.doc(id).collection('heSoPhu').doc(id2).set({
                //   'nam': namController.text,
                //   'heSoPhu': int.tryParse(heSoController.text),
                //   'id': id2,
                // });

                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/ChucVu');
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
