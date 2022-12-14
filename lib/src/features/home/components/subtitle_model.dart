import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubTitleModel extends StatefulWidget {
  
  final String texto;
  final int cor;

  const SubTitleModel({
    Key? key,
    required this.texto,
    this.cor = 0xff64758B,
  }) : super(key: key);

  @override
  _SubTitleModelState createState() => _SubTitleModelState();
}

class _SubTitleModelState extends State<SubTitleModel> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.texto,
      style: GoogleFonts.montserrat(
        fontSize: 16.0,
        color: Color(widget.cor),
      ), // style
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    );
  }
}