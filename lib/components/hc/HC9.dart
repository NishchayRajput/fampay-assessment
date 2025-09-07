import 'package:flutter/material.dart';
import 'package:fampay/model/cards.dart';
import 'package:fampay/components/BaseCard.dart';

import '../shared/autoSizeImage.dart';

class HC9CardGroup extends StatelessWidget {
  const HC9CardGroup({required this.cards, required this.height, this.isScrollable = false});

  final List<CardModel> cards;
  final double height;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final card = cards[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: HC9Card(card: card, height: height),
          );
        },
      ),
    );
  }
}

class HC9Card extends StatelessWidget {
  const HC9Card({required this.card, required this.height,  this.width});

  final CardModel card;
  final double height;
  final double? width;
  // final bool? scrollable;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      card: card,
      height: height,
      width: width?? height, // Maintain aspect ratio
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            if (card.bgImage?.imageUrl != null)
              AutoSizeImage(
                url: card.bgImage!.imageUrl,
                height: height,

              ),
            if (card.bgGradient != null)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: card.bgGradient!.colors.map((color) => Color(int.parse(color.replaceFirst('#', '0xff')))).toList(),
                    transform: GradientRotation(card.bgGradient!.angle * (3.14159265359 / 180)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}