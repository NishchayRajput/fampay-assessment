import 'package:flutter/cupertino.dart';
import 'package:fampay/model/formattedText.dart';
import 'package:flutter/gestures.dart';
import 'package:fampay/utils/launchUrl.dart';

import '../../utils/parse_color.dart';

class FormattedOrPlainText extends StatelessWidget {
  const FormattedOrPlainText({
    required this.title,
    required this.fallback,
    required this.style,
    this.maxLines,
  });
  final FormattedText? title;
  final String? fallback;
  final TextStyle style;
  final int? maxLines;



  @override
  Widget build(BuildContext context) {

    if (title == null) {
      return Text(
        fallback ?? '',
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: style,
      );
    }
    return FormattedTextView(ft: title!, baseStyle: style, maxLines: maxLines);
  }
}

class FormattedTextView extends StatelessWidget {
  const FormattedTextView({
    required this.ft,
    required this.baseStyle,
    this.maxLines,
  });
  final FormattedText ft;
  final TextStyle baseStyle;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final spans = <InlineSpan>[];
    final tokens = _tokenizeBraces(ft.text);
    int entityIdx = 0;
    for (final t in tokens) {
      if (t == '{}') {
        if (entityIdx < ft.entities.length) {
          final e = ft.entities[entityIdx++];
          final ts = baseStyle.merge(
            TextStyle(
              color: e.color != null ? parseColor(e.color!) : baseStyle.color,
              decoration:
                  e.fontStyle == 'underline'
                      ? TextDecoration.underline
                      : TextDecoration.none,
              fontStyle:
                  e.fontStyle == 'italic' ? FontStyle.italic : FontStyle.normal,
              fontWeight: FontWeight.w700,
            ),
          );
          if (e.url != null) {
            spans.add(
              TextSpan(
                text: e.text,
                style: ts,
                recognizer:
                    (TapGestureRecognizer()..onTap = () => tryLaunch(e.url)),
              ),
            );
          } else {
            spans.add(TextSpan(text: e.text, style: ts));
          }
        } else {
          spans.add(const TextSpan(text: '{}'));
        }
      } else {
        spans.add(TextSpan(text: t, style: baseStyle));
      }
    }
    return RichText(
      text: TextSpan(children: spans),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}

List<String> _tokenizeBraces(String s) {
  // Splits into literals and "{}" markers, preserving order.
  final out = <String>[];
  int i = 0;
  while (i < s.length) {
    final idx = s.indexOf('{}', i);
    if (idx == -1) {
      out.add(s.substring(i));
      break;
    }
    if (idx > i) out.add(s.substring(i, idx));
    out.add('{}');
    i = idx + 2;
  }
  if (out.isEmpty) out.add(s);
  return out;
}
