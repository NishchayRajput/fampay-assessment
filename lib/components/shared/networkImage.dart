import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImage extends StatelessWidget {
  const NetworkImage({required this.url, this.width, this.height, this.fit});
  final String url; final double? width; final double? height; final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      placeholder: (_, __) => Container(color: Colors.grey.shade200),
      errorWidget: (_, __, ___) => Container(color: Colors.grey.shade300, child: const Icon(Icons.broken_image_outlined)),
    );
  }
}
