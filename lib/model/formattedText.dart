import 'entity.dart';

class FormattedText {
  final String text; // e.g. "Hello {}, click {}"
  final String align;
  final List<Entity> entities; // ordered, for each {}
  FormattedText({required this.text,required this.align ,required this.entities});
  factory FormattedText.fromJson(Map<String, dynamic> json) => FormattedText(
    text: json['text']?.toString() ?? '',
    align: json['align']?.toString() ?? 'left',
    entities:
        ((json['entities'] ?? []) as List)
            .map((e) => Entity.fromJson(e as Map<String, dynamic>))
            .toList(),
  );
}
