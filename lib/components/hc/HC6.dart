import 'package:flutter/material.dart';
import 'package:fampay/model/cards.dart';

import '../BaseCard.dart';
import '../shared/formattedPlainText.dart';
class HC6Card extends StatelessWidget {
  const HC6Card({required this.card, required this.height});
  final CardModel card;
  final double height;
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      card: card,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (card.icon?.imageUrl != null) ...[
            Image.network(
              card.icon!.imageUrl!,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: FormattedOrPlainText(title: card.formattedTitle, fallback: card.title, maxLines: 2, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600,)),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
