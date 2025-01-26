import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Modifiedtext extends StatelessWidget{
  final String text;
  final Color color;
  final double size;

  const Modifiedtext({super.key, required this.text, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Text(text,style: GoogleFonts.lato(color: color,fontSize: size),);
  }
}


Text boldtext({ required String text, required Color color, required double size}){
    return Text(text,style: GoogleFonts.lato(color: color,fontSize: size,fontWeight: FontWeight.bold));
}
