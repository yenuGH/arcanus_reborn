// ignore_for_file: unnecessary_this

class UserAnimeResult {
  int id;
  String titleUserPreferred;
  String titleEnglish;
  String titleRomaji;
  String titleNative;
  String description;
  List<String> genres;
  String type;
  int averageScore;
  String coverImage;
  int episodes;
  Map<String, dynamic> nextAiringEpisode;
  String status;

  UserAnimeResult({
    required this.id,
    required this.titleUserPreferred,
    required this.titleEnglish,
    required this.titleRomaji,
    required this.titleNative,
    required this.description,
    required this.genres,
    required this.type,
    required this.averageScore,
    required this.coverImage,
    required this.episodes,
    required this.nextAiringEpisode,
    required this.status,
  });

  factory UserAnimeResult.fromJson(Map<String, dynamic> json) {
    UserAnimeResult userAnimeResult = UserAnimeResult(
      id: json['id'] as int? ?? 0,
      titleUserPreferred: json['title']['userPreferred'] as String? ?? "",
      titleEnglish: json['title']['english'] as String? ?? "",
      titleRomaji: json['title']['romaji'] as String? ?? "",
      titleNative: json['title']['native'] as String? ?? "",
      description: json['description'] as String? ?? "",
      genres: List<String>.from(json['genres'] as List<dynamic>? ?? []),
      type: "ANIME",
      averageScore: json['averageScore'] as int? ?? 0,
      coverImage: json['coverImage']['extraLarge'] as String? ?? "",
      episodes: json['episodes'] as int? ?? 0,
      nextAiringEpisode: Map<String, dynamic>.from(json['nextAiringEpisode'] as Map<String, dynamic>? ?? {}),
      status: json['status'] as String? ?? "",
    );

    if (userAnimeResult.status == "RELEASING") {
      userAnimeResult.status = "RELEASING";
    }
    else if (userAnimeResult.status == "FINISHED") {
      userAnimeResult.status = "FINISHED";
    }
    else if (userAnimeResult.status == "NOT_YET_RELEASED") {
      userAnimeResult.status = "UNRELEASED";
    }
    else if (userAnimeResult.status == "CANCELLED") {
      userAnimeResult.status = "CANCELLED";
    }
    else if (userAnimeResult.status == "HIATUS") {
      userAnimeResult.status = "HIATUS";
    }
    else {
      userAnimeResult.status = "UNKNOWN";
    }

    return userAnimeResult;
  }

  UserAnimeResult getUserAnimeResult() {
    return this;
  }
}