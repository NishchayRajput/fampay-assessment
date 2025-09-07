class CardImage {
  final String imageType; // asset or external
  final String? assetType;
  final String? imageUrl;
  final double? aspectRatio;
  CardImage({required this.imageType, this.assetType, this.imageUrl, this.aspectRatio});
  factory CardImage.fromJson(Map<String, dynamic> json) => CardImage(
    imageType: json['image_type']?.toString() ?? 'external',
    assetType: json['asset_type']?.toString(),
    imageUrl: json['image_url']?.toString(),
    aspectRatio: json['aspect_ratio'].toDouble()
  );
}