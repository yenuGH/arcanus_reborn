// ignore_for_file: unnecessary_this

class AnimeResult {
  final int id;
  final String title;
  final String type;
  final int averageScore;
  final String coverImage;
  final int episodes;
  final String status;

  AnimeResult({
    required this.id,
    required this.title,
    required this.type,
    required this.averageScore,
    required this.coverImage,
    required this.episodes,
    required this.status,
  });

  factory AnimeResult.fromJson(Map<String, dynamic> json) {
    return AnimeResult(
      id: json['id'] as int? ?? 0,
      title: json['title']['userPreferred'] as String? ?? "",
      type: "ANIME",
      averageScore: json['averageScore'] as int? ?? 0,
      coverImage: json['coverImage']['extraLarge'] as String? ?? "",
      episodes: json['episodes'] as int? ?? 0,
      status: json['status'] as String? ?? "",
    );
  }

  AnimeResult getAnimeResult() {
    return this;
  }

  void printMediaResult() {
    print("id: " + this.id.toString());
    print("title: " + this.title);
    print("type: " + this.type);
    print("averageScore: " + this.averageScore.toString());
    print("coverImage: " + this.coverImage);
    print("episodes: " + this.episodes.toString());
    print("status: " + this.status);
  }
}