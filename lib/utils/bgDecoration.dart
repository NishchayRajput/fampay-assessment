import 'package:flutter/material.dart';
import 'package:fampay/model/cards.dart';
import 'package:fampay/utils/parse_color.dart';
import 'dart:math' as math;
BoxDecoration? bgDecoration(CardModel card) {
  if (card.bgGradient != null) {
    final g = card.bgGradient!;
    final colors = g.colors.map(parseColor).toList();
    final radians = (g.angle) * (math.pi / 180);
    // Convert angle to Alignment begin/end (0 degrees = left->right)
    final begin = Alignment(math.cos(radians + math.pi), math.sin(radians + math.pi));
    final end = Alignment(math.cos(radians), math.sin(radians));
    return BoxDecoration(
      gradient: LinearGradient(colors: colors, begin: begin, end: end),
      borderRadius: BorderRadius.circular(16),
    );
  }
  if (card.bgColor != null) {
    return BoxDecoration(color: parseColor(card.bgColor!), borderRadius: BorderRadius.circular(16));
  }
  return null;
}
