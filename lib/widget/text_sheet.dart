import 'package:rtracker/helper/dimensions.dart';
import 'package:flutter/material.dart';

class TextSheet extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final double opacity;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? fontFamily;
  final double? letterSpacing;
  final double? lineHeight;
  final FontStyle? fontStyle;

  const TextSheet(
    this.text, {
    Key? key,
    this.color,
    this.fontSize = 0,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
    this.opacity = 1,
    this.overflow,
    this.maxLines,
    this.fontFamily,
    this.letterSpacing,
    this.lineHeight,
    this.fontStyle = FontStyle.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color?.withOpacity(opacity),
        fontSize: fontSize == 0 ? Dimensions.size14 : fontSize,
        fontWeight: fontWeight,
        overflow: overflow,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
        height: lineHeight,
        fontStyle: fontStyle,
      ),
      maxLines: maxLines,
    );
  }
}
