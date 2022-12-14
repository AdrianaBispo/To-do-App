import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextitleModel extends StatelessWidget {
  final String texto;
  final int cor;

  const TextitleModel({
    Key? key,
    required this.texto,
    this.cor = 0xff2D3A4A,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: GoogleFonts.montserrat(
        fontSize: 19.0,
        color: Color(cor),
      ), // style
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    );
  }
}