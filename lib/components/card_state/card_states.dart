import 'package:fampay/model/card_group.dart';

class CardsState {}

class CardsLoading extends CardsState {}

class CardsError extends CardsState {
  final String message;
  CardsError(this.message);
}

class CardsSuccess extends CardsState {
  final List<CardGroup> groups;
  CardsSuccess(this.groups);
}
