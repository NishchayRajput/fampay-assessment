import 'package:fampay/components/unkownCard.dart';
import 'package:flutter/material.dart';
import 'package:fampay/model/card_group.dart';
import 'package:fampay/model/cards.dart';
import '../utils/parse_color.dart';
import 'hc/HC1.dart';
import 'hc/HC3.dart';
import 'hc/HC5.dart';
import 'hc/HC9.dart';
import 'hc/HC6.dart';

class CardGroupWidget extends StatelessWidget {
  const CardGroupWidget({required this.group, required this.onAction});
  final CardGroup group;
  final void Function(HC3Action action, CardModel card) onAction;

  @override
  Widget build(BuildContext context) {
    final cards = group.cards;
    final isHC9 = group.designType == 'HC9';
    final isHC6 = group.designType == 'HC6';
    final horizontal = (group.isScrollable ?? false) || isHC9;

    final list = ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: cards.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(width: 12, height: 12),
      itemBuilder:
          (context, index) => _OneCard(
            designType: group.designType,
            card: cards[index],
            groupHeight: group.height,
            width: isHC9 ? group.width : null,
            isScrollable: group.isScrollable ?? false,
            onAction: (a) => onAction(a, cards[index]),
          ),
    );

    if (horizontal) {
      return SizedBox(
        height: group.height ?? _groupHeightFor(group),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _OneCard(
              designType: group.designType,
              card: cards[index],
              groupHeight: group.height,
              isScrollable: group.isScrollable ?? false,
              onAction: (a) => onAction(a, cards[index]),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemCount: cards.length,
        ),
      );
    }

    if (group.designType == 'HC1') {
      if (group.isScrollable ?? false) {
        return SizedBox(
          height: group.height ?? _groupHeightFor(group),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: cards.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width - 100,
                height: group.height ?? _groupHeightFor(group),
                decoration: BoxDecoration(
                  color: parseColor(group.cards[index].bgColor!),

                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: _OneCard(
                  designType: group.designType,
                  card: cards[index],
                  groupHeight: group.height,
                  isScrollable: true,
                  onAction: (a) => onAction(a, cards[index]),
                ),
              );
            },
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: group.height ?? _groupHeightFor(group),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
                  cards.asMap().entries.map((entry) {
                    final index = entry.key;
                    final card = entry.value;
                    return Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: parseColor(group.cards[index].bgColor!),

                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          width: double.infinity, // Divide width among elements
                          child: _OneCard(
                            designType: group.designType,
                            card: card,
                            groupHeight: group.height,
                            isScrollable: false,
                            onAction: (a) => onAction(a, card),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: list,
    );
  }

  double _groupHeightFor(CardGroup g) {
    if (g.designType == 'HC9' && g.height != null) return g.height!;
    switch (g.designType) {
      case 'HC1':
        return 120;
      case 'HC3':
        return 220;
      case 'HC5':
        return 180;
      case 'HC6':
        return 100;
      default:
        return 160;
    }
  }
}

class _OneCard extends StatefulWidget {
  const _OneCard({
    required this.designType,
    required this.card,
    required this.onAction,
    this.groupHeight,
    this.width,
    this.isScrollable = false,
  });
  final String designType;
  final CardModel card;
  final double? groupHeight;
  final ValueChanged<HC3Action> onAction;
  final double? width;
  final bool isScrollable;
  @override
  State<_OneCard> createState() => _OneCardState();
}

class _OneCardState extends State<_OneCard>
    with SingleTickerProviderStateMixin {
  bool _hc3ShowActions = false; // for long-press slide on HC3

  @override
  Widget build(BuildContext context) {
    final child = switch (widget.designType) {
      'HC1' => HC1Card(
        card: widget.card,
        height: widget.groupHeight ?? 120,
        isScrollable: widget.isScrollable,
      ),
      'HC3' => HC3Card(
        card: widget.card,
        showActions: _hc3ShowActions,
        onAction: widget.onAction,
        height: widget.groupHeight ?? 220,
      ),
      'HC5' => HC5Card(card: widget.card, height: widget.groupHeight ?? 180),
      'HC6' => HC6Card(card: widget.card, height: widget.groupHeight ?? 100),
      'HC9' => HC9Card(
        card: widget.card,
        height: widget.groupHeight ?? 140,
        width: widget.width,
      ),
      _ => UnknownCard(card: widget.card),
    };

    if (widget.designType == 'HC3') {
      return GestureDetector(
        onLongPress: () => setState(() => _hc3ShowActions = !_hc3ShowActions),
        child: child,
      );
    }
    return child;
  }
}
