class CtaModel {
  final String text;
  final String? bgColor;
  final String? url;
  final String? textColor;
  CtaModel({required this.text, this.bgColor, this.url, this.textColor});
  factory CtaModel.fromJson(Map<String, dynamic> json) => CtaModel(
    text: json['text']?.toString() ?? '',
    bgColor: json['bg_color']?.toString(),
    url: json['url']?.toString(),
    textColor: json['text_color']?.toString(),
  );
}