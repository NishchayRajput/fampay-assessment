class GradientModel {
  final List<String> colors; // ARGB hexes like #FFAA11..
  final double angle; // degrees; assume 0 if null
  GradientModel({required this.colors, required this.angle});
  factory GradientModel.fromJson(Map<String, dynamic> json) => GradientModel(
    colors: ((json['colors'] ?? []) as List).map((e) => e.toString()).toList(),
    angle: (json['angle'] is num) ? (json['angle'] as num).toDouble() : 0,
  );
}
