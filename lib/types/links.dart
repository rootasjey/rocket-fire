class Links {
  final String article;
  final String video;

  Links({
    required this.article,
    required this.video,
  });

  factory Links.empty() {
    return Links(
      article: '',
      video: '',
    );
  }

  factory Links.fromJSON(Map<String, dynamic>? data) {
    if (data == null) {
      return Links.empty();
    }

    return Links(
      article: data['article_link'] ?? '',
      video: data['video_link'] ?? '',
    );
  }
}
