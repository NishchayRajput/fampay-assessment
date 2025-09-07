import 'package:flutter/cupertino.dart';
import 'package:fampay/components/card_state/card_states.dart';
import 'package:fampay/service/card_remote.dart';
import 'package:fampay/service/card_local.dart';
import 'package:fampay/components/card_state/card_repository.dart';
import 'package:fampay/model/cards.dart';
import 'package:fampay/components/hc/HC3.dart';

class CardsViewModel {
  final ValueNotifier<CardsState> state = ValueNotifier<CardsState>(
    CardsLoading(),
  );
  final _repo = CardsRepository(CardsRemote(), CardsLocal());

  Future<void> load({
    required List<String> slugs,
    required String apiBaseUrl,
    bool force = false,
  }) async {
    state.value = CardsLoading();
    try {
      final groups = await _repo.fetchCardGroups(
        slugs: slugs,
        apiBaseUrl: apiBaseUrl,
        forceNetwork: force,
      );
      state.value = CardsSuccess(groups);
    } catch (e) {
      state.value = CardsError(e.toString());
    }
  }

  Future<void> handleAction({
    required HC3Action action,
    required CardModel card,
  }) async {
    switch (action) {
      case HC3Action.remindLater:
        await _repo.markRemindLater(card);
        break;
      case HC3Action.dismissNow:
        await _repo.markDismissed(card);
        break;
    }
    // After action, refresh silently from last known in-memory list
    if (state.value case CardsSuccess(:final groups)) {
      final filtered = await _repo.filterHidden(groups);
      state.value = CardsSuccess(filtered);
    }
  }

  void dispose() => state.dispose();
}
