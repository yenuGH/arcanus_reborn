// ignore_for_file: unnecessary_this

class SearchAnimeResult {
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

  SearchAnimeResult({
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
  });

  factory SearchAnimeResult.fromJson(Map<String, dynamic> json) {
    SearchAnimeResult searchAnimeResult = SearchAnimeResult(
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
      progress: json['progress'] as int? ?? 0,
      nextAiringEpisode: Map<String, dynamic>.from(json['nextAiringEpisode'] as Map<String, dynamic>? ?? {}),
      status: json['status'] as String? ?? "",
    );

    if (searchAnimeResult.status == "RELEASING") {
      searchAnimeResult.status = "RELEASING";
    }
    else if (searchAnimeResult.status == "FINISHED") {
      searchAnimeResult.status = "FINISHED";
    }
    else if (searchAnimeResult.status == "NOT_YET_RELEASED") {
      searchAnimeResult.status = "UNRELEASED";
    }
    else if (searchAnimeResult.status == "CANCELLED") {
      searchAnimeResult.status = "CANCELLED";
    }
    else if (searchAnimeResult.status == "HIATUS") {
      searchAnimeResult.status = "HIATUS";
    }
    else {
      searchAnimeResult.status = "UNKNOWN";
    }

    return searchAnimeResult;
  }

  SearchAnimeResult getAnimeResult() {
    return this;
  }
}