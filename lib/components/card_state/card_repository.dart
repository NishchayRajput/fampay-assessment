import 'dart:developer';

import 'package:fampay/service/card_remote.dart';
import 'package:fampay/service/card_remote.dart';
import 'package:fampay/service/card_local.dart';
import 'package:fampay/model/card_group.dart';
import 'package:fampay/model/cards.dart';

class CardsRepository {
  CardsRepository(this.remote, this.local);
  final CardsRemote remote;
  final CardsLocal local;

  Future<List<CardGroup>> fetchCardGroups({
    required List<String> slugs,
    required String apiBaseUrl,
    bool forceNetwork = false,
  }) async {
    final groups = await remote.fetch(slugs: slugs, apiBaseUrl: apiBaseUrl);

    final filtered = await filterHidden(groups);
    return filtered;
  }

  Future<List<CardGroup>> filterHidden(List<CardGroup> groups) async {
    final dismissed = await local.getDismissedIds();
    final remindLater = await local.getSessionRemindLaterIds();
    List<CardGroup> result = [];
    for (final g in groups) {
      final cards =
          g.cards
              .where(
                (c) =>
                    !dismissed.contains(c.stableId) &&
                    !remindLater.contains(c.stableId),
              )
              .toList();
      if (cards.isNotEmpty) {
        result.add(g.copyWith(cards: cards));
      }
    }
    return result;
  }

  Future<void> markRemindLater(CardModel card) async =>
      local.addSessionRemindLater(card.stableId);
  Future<void> markDismissed(CardModel card) async =>
      local.addDismissed(card.stableId);
}
