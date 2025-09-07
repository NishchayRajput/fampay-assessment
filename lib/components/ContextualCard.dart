import 'package:flutter/material.dart';
import 'package:fampay/components/card_state/card_model.dart';
import 'package:fampay/components/card_state/card_states.dart';
import 'package:fampay/components/centerLoader.dart';
import 'package:fampay/components/view/errorView.dart';
import 'package:fampay/components/view/emptyView.dart';

import 'cardWidget.dart';

class ContextualCard extends StatefulWidget {
  const ContextualCard({super.key, required this.slugs, required this.apiURL});

  final List<String> slugs;
  final String apiURL;

  @override
  State<ContextualCard> createState() => _ContextualCardState();
}

class _ContextualCardState extends State<ContextualCard> {
  final _vm = CardsViewModel();

  @override
  void initState() {
    super.initState();
    _vm.load(slugs: widget.slugs, apiBaseUrl: widget.apiURL);
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:
          () => _vm.load(
            slugs: widget.slugs,
            apiBaseUrl: widget.apiURL,
            force: true,
          ),
      child: ValueListenableBuilder<CardsState>(
        valueListenable: _vm.state,
        builder: (context, state, _) {
          if (state is CardsLoading) {
            return const CenteredLoader();
          }
          if (state is CardsError) {
            return ErrorView(
              message: state.message,
              onRetry:
                  () => _vm.load(
                    slugs: widget.slugs,
                    apiBaseUrl: widget.apiURL,
                    force: true,
                  ),
            );
          }
          final success = state as CardsSuccess;
          if (success.groups.isEmpty) {
            return const EmptyView();
          }
          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: success.groups.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final group = success.groups[index];
              return CardGroupWidget(
                group: group,
                onAction:
                    (action, card) =>
                        _vm.handleAction(action: action, card: card),
              );
              //
            },
          );
        },
      ),
    );
  }
}
