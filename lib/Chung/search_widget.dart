import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(
      color: Color(0xff6D6D6D),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w400,
      fontSize: 12.8,
    );
    final styleHint = TextStyle(
      color: Color(0xff727272),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w400,
      fontSize: 12.8,
    );
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      alignment: Alignment.bottomCenter,
      height: 24,
      width: 156,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffEAEAEB).withOpacity(0.55),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 12, left: 11),
          suffixIcon: widget.text.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 1),
                  child: Icon(
                    Icons.search,
                    color: style.color,
                    size: 22,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 1),
                  child: GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: style.color,
                      size: 22,
                    ),
                    onTap: () {
                      controller.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                ),
          hintText: 'Search..',
          hintStyle: style,
          border: InputBorder.none,
          //icon: Icon(Icons.search, color: style.color),
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
