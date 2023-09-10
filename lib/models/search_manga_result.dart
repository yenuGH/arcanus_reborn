class SearchMangaResult {
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

  SearchMangaResult({
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

  factory SearchMangaResult.fromJson(Map<String, dynamic> json) {
    SearchMangaResult searchMangaResult = SearchMangaResult(
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
      chapters: json['chapters'] as int? ?? 0,
      progress: json['progress'] as int? ?? 0,
      status: json['status'] as String? ?? "",
    );

    if (searchMangaResult.status == "RELEASING") {
      searchMangaResult.status = "RELEASING";
    }
    else if (searchMangaResult.status == "FINISHED") {
      searchMangaResult.status = "FINISHED";
    }
    else if (searchMangaResult.status == "NOT_YET_RELEASED") {
      searchMangaResult.status = "UNRELEASED";
    }
    else if (searchMangaResult.status == "CANCELLED") {
      searchMangaResult.status = "CANCELLED";
    }
    else if (searchMangaResult.status == "HIATUS") {
      searchMangaResult.status = "HIATUS";
    }
    else {
      searchMangaResult.status = "UNKNOWN";
    }

    return searchMangaResult;
  }

  SearchMangaResult getAnimeResult() {
    return this;
  }
}