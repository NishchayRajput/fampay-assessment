import 'dart:async';
import 'package:fampay/components/shared/networkImage.dart' as custom;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AutoSizeImage extends StatefulWidget {
  const AutoSizeImage({required this.url, required this.height});
  final String? url;
  final double height;
  @override
  State<AutoSizeImage> createState() => _AutoSizeImageState();
}

class _AutoSizeImageState extends State<AutoSizeImage> {
  double? _width;
  @override
  void initState() {
    super.initState();
    _resolveSize();
  }

  Future<void> _resolveSize() async {
    if (widget.url == null) return;
    final provider = CachedNetworkImageProvider(widget.url!);
    final completer = Completer<ImageInfo>();
    final stream = provider.resolve(const ImageConfiguration());
    ImageStreamListener? listener;
    listener = ImageStreamListener(
      (info, _) {
        if (!completer.isCompleted) completer.complete(info);
      },
      onError: (e, s) {
        if (!completer.isCompleted) completer.completeError(e, s);
      },
    );
    stream.addListener(listener);
    try {
      final info = await completer.future;
      final aspect = info.image.width / info.image.height;
      setState(() => _width = widget.height * aspect);
    } catch (_) {
      // fallback width
      setState(() => _width = widget.height * 1.4);
    } finally {
      stream.removeListener(listener);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = _width ?? widget.height * 1.2;
    if (widget.url == null) {
      return SizedBox(
        width: w,
        height: widget.height,
        child: Container(color: Colors.grey.shade200),
      );
    }
    return SizedBox(
      // width: w,
      // height: widget.height,
      child: CachedNetworkImage(
        imageUrl: widget.url!,
        width: w,
        height: widget.height,
        fit:  BoxFit.contain,
        placeholder: (_, __) => Container(color: Colors.grey.shade200),
        errorWidget: (_, __, ___) => Container(color: Colors.grey.shade300, child: const Icon(Icons.broken_image_outlined)),
      ),
    );
  }
}
