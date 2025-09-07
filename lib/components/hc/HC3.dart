import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fampay/model/cta.dart';
import 'package:fampay/model/cards.dart';
import 'package:fampay/model/formattedText.dart';
import 'package:url_launcher/url_launcher.dart';
import '../BaseCard.dart';
import 'package:fampay/utils/parse_color.dart';

import '../actionButton.dart';
import '../shared/cta.dart';
import '../shared/formattedPlainText.dart';

class HC3Card extends StatelessWidget {
  const HC3Card({
    required this.card,
    required this.showActions,
    required this.onAction,
    required this.height,
  });
  final CardModel card;
  final bool showActions;
  final ValueChanged<HC3Action> onAction;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Actions surface
        BaseCard(
          card: card,
          height: height,
          width: double.infinity,
          // padding: const EdgeInsets.all(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                ActionButton(
                icon: Icons.notifications_off_outlined,
                label: 'Remind later',
                onTap: () => onAction(HC3Action.remindLater),
              ),
              const SizedBox(width: 12),
              ActionButton(
                icon: Icons.close_rounded,
                label: 'Dismiss now',
                onTap: () => onAction(HC3Action.dismissNow),
              ),
            ],
          ),
        ),
        // Foreground card that slides to reveal actions
        AnimatedSlide(
          duration: const Duration(milliseconds: 220),
          offset: showActions ? const Offset(0.35, 0) : Offset.zero,
          child: BaseCard(
            card: card,
            height: height,
            width: double.infinity,
            imageUrl: card.bgImage?.imageUrl,
            // padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [


                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: FormattedOrPlainText(
                    title: card.formattedTitle,
                    fallback: card.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,

                      // overflow: TextOverflow.visible
                        // wrap: TextOverflow.visible
                    ),
                    maxLines: 4,
                  ),
                ),

                // FormattedOrPlainText(
                //   title: card.formattedDescription,
                //   fallback: card.description,
                //   style: const TextStyle(fontSize: 14, color: Colors.black54, overflow: TextOverflow.clip),
                // ),
                // const Spacer(),
                CtasRow(ctas: card.ctas),
              ],
            ),
          ),
        ),
      ],
    );

  }
}

enum HC3Action { remindLater, dismissNow }
