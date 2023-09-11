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
  int progress;
  Map<String, dynamic> nextAiringEpisode;
  String status;
  String userStatus;

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
    required this.progress,
    required this.nextAiringEpisode,
    required this.status,
    required this.userStatus,
  });

  factory UserAnimeResult.fromJson(Map<String, dynamic> json) {
    UserAnimeResult userAnimeResult = UserAnimeResult(
      id: json['media']['id'] as int? ?? 0,
      titleUserPreferred: json['media']['title']['userPreferred'] as String? ?? "",
      titleEnglish: json['media']['title']['english'] as String? ?? "",
      titleRomaji: json['media']['title']['romaji'] as String? ?? "",
      titleNative: json['media']['title']['native'] as String? ?? "",
      description: json['media']['description'] as String? ?? "",
      genres: List<String>.from(json['media']['genres'] as List<dynamic>? ?? []),
      type: "ANIME",
      averageScore: json['media']['averageScore'] as int? ?? 0,
      coverImage: json['media']['coverImage']['extraLarge'] as String? ?? "",
      episodes: json['media']['episodes'] as int? ?? 0,
      progress: json['progress'] as int? ?? 0,
      nextAiringEpisode: Map<String, dynamic>.from(json['media']['nextAiringEpisode'] as Map<String, dynamic>? ?? {}),
      status: json['media']['status'] as String? ?? "",
      userStatus: json['status'] as String? ?? "",
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

  UserAnimeResult getAnimeResult() {
    return this;
  }
}