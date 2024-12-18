class GalleryItem {
  final String url;
  final String? description;

  GalleryItem({
    required this.url,
    this.description,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) => GalleryItem(
        url: json["url"],
        description: json['description'],
      );
}
