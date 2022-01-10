import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class TextfieldModel extends StatefulWidget {
  final TextEditingController? textController;
  final labelText;

  const TextfieldModel({
    Key? key,
    required this.textController,
    required this.labelText,
  });

  @override
  _TextfieldModelState createState() => _TextfieldModelState();
}

class _TextfieldModelState extends State<TextfieldModel> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          fontSize: 15.0,
          color: Color(0xff2D3A4A),
          fontFamily: 'Montserrat',
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE0E0E0)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff2D3A4A)),
        ),
      ),
    );
  }
}
