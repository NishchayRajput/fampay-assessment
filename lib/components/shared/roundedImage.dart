import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RoundedImage extends StatelessWidget {
  const RoundedImage({required this.url, this.size = 40});
  final String url; final double size;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 5),
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit:  BoxFit.contain,
        placeholder: (_, __) => Container(color: Colors.grey.shade200),
        errorWidget: (_, __, ___) => Container(color: Colors.grey.shade300, child: const Icon(Icons.broken_image_outlined)),
      ),
    );
  }
}
