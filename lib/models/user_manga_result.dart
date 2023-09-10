// ignore_for_file: unnecessary_this

class UserMangaResult {
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
  int chapters;
  int progress;
  String status;

  UserMangaResult({
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
    required this.chapters,
    required this.progress,
    required this.status,
  });

  factory UserMangaResult.fromJson(Map<String, dynamic> json) {
    UserMangaResult userMangaResult = UserMangaResult(
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
      chapters: json['media']['chapters'] as int? ?? 0,
      progress: json['progress'] as int? ?? 0,
      status: json['media']['status'] as String? ?? "",
    );

    if (userMangaResult.status == "RELEASING") {
      userMangaResult.status = "RELEASING";
    }
    else if (userMangaResult.status == "FINISHED") {
      userMangaResult.status = "FINISHED";
    }
    else if (userMangaResult.status == "NOT_YET_RELEASED") {
      userMangaResult.status = "UNRELEASED";
    }
    else if (userMangaResult.status == "CANCELLED") {
      userMangaResult.status = "CANCELLED";
    }
    else if (userMangaResult.status == "HIATUS") {
      userMangaResult.status = "HIATUS";
    }
    else {
      userMangaResult.status = "UNKNOWN";
    }

    return userMangaResult;
  }

  UserMangaResult getAnimeResult() {
    return this;
  }
}