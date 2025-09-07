import 'dart:ui';

Color parseColor(String hex) {
  String c = hex.replaceAll('#', '');
  if (c.length == 6) c = 'FF$c';
  final value = int.parse(c, radix: 16);
  return Color(value);
}