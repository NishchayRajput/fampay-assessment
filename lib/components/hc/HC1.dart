import 'package:flutter/material.dart';
import 'package:fampay/model/cards.dart';
import 'package:fampay/components/BaseCard.dart';

import '../shared/cta.dart';
import '../shared/formattedPlainText.dart';
import '../shared/roundedImage.dart';

class HC1Card extends StatelessWidget {
  const HC1Card({
    required this.card,
    required this.height,
    this.isScrollable = false,
  });
  final CardModel card;
  final bool isScrollable;
  final double height;

  @override
  Widget build(BuildContext context) {
    print(isScrollable);
    return ListTile(
      leading:
          card.icon?.imageUrl != null
              ? RoundedImage(url: card.icon!.imageUrl!)
              : null,
      title: FormattedOrPlainText(
        title: card.formattedTitle,
        fallback: card.title ?? 'No Title',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black, // Ensure text is visible
        ),
      ),
      subtitle: FormattedOrPlainText(
        title: card.formattedDescription,
        fallback: card.description ?? '',
        style: const TextStyle(fontSize: 13, color: Colors.black54),
      ),
      trailing: CtasRow(ctas: card.ctas),
    );
  }
}
