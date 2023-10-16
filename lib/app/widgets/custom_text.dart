import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final Color color;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? minFontSize;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const CustomText({
    Key? key,
    this.text,
    this.fontSize,
    this.letterSpacing = 1.2,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w500,
    this.maxLines = 1,
    this.minFontSize = 13,
    this.decoration,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ResponsiveUI().fontSize(6)
    return AutoSizeText(
      '$text',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        decoration: decoration != null ? decoration : null,
      ),
      wrapWords: true,
      softWrap: true,
      overflow: overflow,
      maxLines: maxLines,
      // maxFontSize: fontSize!,
      minFontSize: minFontSize!,
      textAlign: textAlign,
    );
  }
}
