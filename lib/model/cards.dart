import 'formattedText.dart';
import 'cardImage.dart';
import 'gradient.dart';
import 'cta.dart';

class CardModel {
  final String name;
  final FormattedText? formattedTitle;
  final String? title;
  final FormattedText? formattedDescription;
  final String? description;
  final CardImage? icon;
  final String? url;
  final CardImage? bgImage;
  final String? bgColor;
  final GradientModel? bgGradient;
  final List<CtaModel> ctas;


  CardModel({
    required this.name,
    required this.formattedTitle,
    required this.title,
    required this.formattedDescription,
    required this.description,
    required this.icon,
    required this.url,
    required this.bgImage,
    required this.bgColor,
    required this.bgGradient,
    required this.ctas,
  });

  String get stableId {
    final raw = [name, title ?? '', description ?? '', icon?.imageUrl ?? '', bgImage?.imageUrl ?? '', url ?? ''].join('|');
    return raw.hashCode.toString();
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      name: json['name']?.toString() ?? '',
      formattedTitle: json['formatted_title'] != null
          ? FormattedText.fromJson(json['formatted_title'] as Map<String, dynamic>)
          : null,
      title: json['title']?.toString(),
      formattedDescription: json['formatted_description'] != null
          ? FormattedText.fromJson(json['formatted_description'] as Map<String, dynamic>)
          : null,
      description: json['description']?.toString(),
      icon: json['icon'] != null ? CardImage.fromJson(json['icon'] as Map<String, dynamic>) : null,
      url: json['url']?.toString(),
      bgImage: json['bg_image'] != null ? CardImage.fromJson(json['bg_image'] as Map<String, dynamic>) : null,
      bgColor: json['bg_color']?.toString(),
      bgGradient: json['bg_gradient'] != null ? GradientModel.fromJson(json['bg_gradient'] as Map<String, dynamic>) : null,
      ctas: ((json['cta'] ?? []) as List).map((e) => CtaModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
