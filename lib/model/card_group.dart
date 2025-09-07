import 'cards.dart';

class CardGroup {
  final String name;
  final String designType; // HC1, HC3, HC5, HC6, HC9
  final List<CardModel> cards;
  final double? height; // Only used for HC9
  final double? width;//
  final bool? isScrollable; // Ignored for HC9

  CardGroup({
    required this.name,
    required this.designType,
    required this.cards,
    this.height,
    this.width,
    this.isScrollable,
  });

  factory CardGroup.fromJson(Map<String, dynamic> json) {
    return CardGroup(
      name: json['name']?.toString() ?? '',
      designType: json['design_type']?.toString() ?? '',
      cards: ((json['cards'] ?? []) as List).map((e) => CardModel.fromJson(e as Map<String, dynamic>)).toList(),
      height: (json['height'] is num) ? (json['height'] as num).toDouble() : null,
      width: (json['width'] is num) ? (json['width'] as num).toDouble() : null,
      isScrollable: json['is_scrollable'] is bool ? json['is_scrollable'] as bool : null,
    );
  }

  CardGroup copyWith({List<CardModel>? cards}) => CardGroup(
    name: name,
    designType: designType,
    cards: cards ?? this.cards,
    height: height,
    width: width,
    isScrollable: isScrollable,
  );
}