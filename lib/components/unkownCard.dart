import 'package:flutter/material.dart';
import 'package:fampay/model/cards.dart';
import 'BaseCard.dart';

class UnknownCard extends StatelessWidget {
  const UnknownCard({required this.card});
  final CardModel card;
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      card: card,
      padding: const EdgeInsets.all(16),
      child: const Text('Unsupported card'),
    );
  }
}