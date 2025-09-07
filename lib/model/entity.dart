class Entity {
  final String text; // to replace {}
  final String? color; // hex
  final String? url; // deeplink
  final String? fontStyle; // underline / italic
  final String? fontFamily; // custom font family
  Entity({required this.text, this.color, this.url, this.fontStyle, this.fontFamily});
  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
    text: json['text']?.toString() ?? '',
    color: json['color']?.toString(),
    url: json['url']?.toString(),
    fontStyle: json['font_style']?.toString(),
    fontFamily: json['font_family']?.toString(),
  );
}