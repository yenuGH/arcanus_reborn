class AnimeResult {
  final int id;
  final String title;
  final int averageScore;
  final String coverImage;
  final int episodes;
  final String status;

  AnimeResult({
    required this.id,
    required this.title,
    required this.averageScore,
    required this.coverImage,
    required this.episodes,
    required this.status,
  });

  factory AnimeResult.fromJson(Map<String, dynamic> json) {
    return AnimeResult(
      id: json['id'] as int? ?? 0,
      title: json['title']['userPreferred'] as String? ?? "",
      averageScore: json['averageScore'] as int? ?? 0,
      coverImage: json['coverImage']['extraLarge'] as String? ?? "",
      episodes: json['episodes'] as int? ?? 0,
      status: json['status'] as String? ?? "",
    );
  }

  AnimeResult getAnimeResult() {
    return this;
  }

  void printAnimeResult() {
    print("Anime Result: ");
    print("id: " + id.toString());
    print("title: " + title);
    print("averageScore: " + averageScore.toString());
    print("coverImage: " + coverImage);
    print("episodes: " + episodes.toString());
    print("status: " + status);
  }
}