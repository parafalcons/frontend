class Video {
  final String title;
  final String description;
  final String s3Url;
  final String streamUrl;
  final int? duration;

  Video({
    required this.title,
    required this.description,
    required this.s3Url,
    required this.streamUrl,
    this.duration,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      s3Url: json['s3Url'] ?? '',
      streamUrl: json['streamUrl'] ?? '',
      duration: json['duration'], // Nullable integer
    );
  }
}
