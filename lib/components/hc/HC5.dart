import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fampay/components/BaseCard.dart';
import 'package:fampay/model/cards.dart';

import '../../utils/bgDecoration.dart';

class HC5Card extends StatelessWidget {
  const HC5Card({required this.card, required this.height});
  final CardModel card;
  final double height;
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 180,
    //   color: Colors.green,
    //   child: Center(child: Text(card.title ?? "No Title", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
    // );
    return BaseCard(
      card: card,
      height: 180,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (card.bgImage?.imageUrl != null)
              // NetworkImage(url: card.bgImage!.imageUrl!, fit: BoxFit.cover),
              CachedNetworkImage(
                imageUrl: card.bgImage!.imageUrl!,
                fit: BoxFit.fill,
                placeholder: (_, __) => Container(color: Colors.grey.shade200),
                errorWidget:
                    (_, __, ___) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image_outlined),
                    ),
              ),
            if (card.bgColor != null || card.bgGradient != null)
              Container(decoration: bgDecoration(card)),
          ],
        ),
      ),
    );
  }
}
