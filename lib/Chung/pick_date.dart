// import 'package:flutter/material.dart';
// import 'button_pick_date.dart';

// class DatePickerWidget extends StatefulWidget {
//   DateTime? date;
//   double width;
//   String title;
//   DatePickerWidget({this.date, required this.width, required this.title});
//   @override
//   _DatePickerWidgetState createState() => _DatePickerWidgetState();
// }

// class _DatePickerWidgetState extends State<DatePickerWidget> {
//   DateTime? date;

//   @override
//    Widget build(BuildContext context) => ButtonHeaderWidget(
//         title: 'Date',
//         text: getText(),
//         onClicked: () => pickDate(context),
//       );


//   String getText() {
//     if (date == null)
//       return 'Eg:. 03/11/2001';
//     else
//       return '${date!.day}/${date!.month}/${date!.year}';
//   }

//   Future pickDate(BuildContext context) async {
//     date = widget.date;
//     final initialDate = DateTime.now();
//     final newDate = await showDatePicker(
//       context: context,
//       initialDate: date ?? initialDate,
//       firstDate: DateTime(DateTime.now().year - 20),
//       lastDate: DateTime(DateTime.now().year + 20),
//     );
//     if (newDate == null) return;

//     setState(() {
//       date = newDate;
//     });
//   }
// }

// Widget _customTitle(String title) {
//   return Text(
//     title,
//     style: TextStyle(
//       fontFamily: 'HelveticaNeue',
//        fontWeight: FontWeight.w400,
//       fontSize: 12.8,
//     ),
//   );
// }

// Widget _customText(String text) {
//   return Text(
//     text,
//     style: TextStyle(
//       fontFamily: 'HelveticaNeue',
//       fontWeight: FontWeight.w400,
//       fontSize: 16,
//     ),
//   );
// }
