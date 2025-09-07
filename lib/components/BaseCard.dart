import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fampay/model/cards.dart';

import '../utils/bgDecoration.dart';
import '../utils/launchUrl.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({
    required this.card,
    required this.child,
    this.height,
    this.width,
    this.padding,
    this.imageUrl,
  });
  final CardModel card;
  final Widget child;
  final double? height;
  final double? width;
  final String? imageUrl;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    final bg = bgDecoration(card);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        image: imageUrl != null
            ? DecorationImage(
          image: NetworkImage(imageUrl!),
          fit: BoxFit.fill,
        )
            : null,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => tryLaunch(card.url),
        child: Ink(
          decoration: bg,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(8),
            child: child,
          ),
        ),
      ),
    );


  }
}
