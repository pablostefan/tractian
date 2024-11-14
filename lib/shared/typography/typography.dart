import 'package:flutter/material.dart';
import 'package:tractian/shared/typography/font_family.dart';
import 'package:tractian/shared/typography/typography_font_size.dart';
import 'package:tractian/shared/typography/typography_font_weight.dart';
import 'package:tractian/shared/typography/typography_line_height.dart';
import 'package:tractian/shared/ui/app_colors.dart';

extension TypographyExtension on Text {
  Text bodySmallMedium({TextStyle? style}) {
    TextStyle defaultStyle = _getTextStyle(
        fontSize: TypographyFontSize.small,
        fontWeight: TypographyFontWeight.medium,
        height: TypographyLineHeight.body,
        mergeStyle: style);

    return _getTextTypography(text: this, textStyle: defaultStyle);
  }

  Text _getTextTypography({required Text text, required TextStyle textStyle}) {
    return Text(text.data!,
        style: textStyle,
        key: text.key,
        strutStyle: text.strutStyle,
        textAlign: text.textAlign,
        textDirection: text.textDirection,
        locale: text.locale,
        softWrap: text.softWrap,
        overflow: text.overflow,
        maxLines: text.maxLines,
        semanticsLabel: text.semanticsLabel,
        textWidthBasis: text.textWidthBasis,
        textHeightBehavior: text.textHeightBehavior);
  }

  TextStyle _getTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    double? letterSpacing,
    required TextStyle? mergeStyle,
  }) {
    return TextStyle(
            fontSize: fontSize,
            fontStyle: FontStyle.normal,
            height: height,
            color: AppColors.primaryText,
            fontFamily: FontFamily.roboto.font,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight)
        .merge(mergeStyle);
  }

  Text color(Color color) {
    return Text(data!,
        style: style!.copyWith(color: color),
        key: key,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior);
  }

  TextSpan toTextSpan({List<TextSpan>? children}) => TextSpan(text: data, style: style, children: children ??= []);
}
