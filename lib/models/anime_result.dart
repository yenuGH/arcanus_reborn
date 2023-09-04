// ignore_for_file: unnecessary_this

class AnimeResult {
  int id;
  String title;
  String type;
  int averageScore;
  String coverImage;
  int episodes;
  String status;

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
    AnimeResult animeResult = AnimeResult(
      id: json['id'] as int? ?? 0,
      title: json['title']['userPreferred'] as String? ?? "",
      type: "ANIME",
      averageScore: json['averageScore'] as int? ?? 0,
      coverImage: json['coverImage']['extraLarge'] as String? ?? "",
      episodes: json['episodes'] as int? ?? 0,
      status: json['status'] as String? ?? "",
    );

    if (animeResult.status == "RELEASING") {
      animeResult.status = "RELEASING";
    }
    else if (animeResult.status == "FINISHED") {
      animeResult.status = "FINISHED";
    }
    else if (animeResult.status == "NOT_YET_RELEASED") {
      animeResult.status = "UNRELEASED";
    }
    else if (animeResult.status == "CANCELLED") {
      animeResult.status = "CANCELLED";
    }
    else if (animeResult.status == "HIATUS") {
      animeResult.status = "HIATUS";
    }
    else {
      animeResult.status = "UNKNOWN";
    }

    return animeResult;
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