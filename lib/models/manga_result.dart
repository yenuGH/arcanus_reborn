class MangaResult {
  final int id;
  final String title;
  final int averageScore;
  final String coverImage;
  final int chapters;
  final String status;

  MangaResult({
    required this.id,
    required this.title,
    required this.averageScore,
    required this.coverImage,
    required this.chapters,
    required this.status,
  });

  factory MangaResult.fromJson(Map<String, dynamic> json) {
    return MangaResult(
      id: json['id'] as int? ?? 0,
      title: json['title']['userPreferred'] as String? ?? "",
      averageScore: json['averageScore'] as int? ?? 0,
      coverImage: json['coverImage']['extraLarge'] as String? ?? "",
      status: json['status'] as String? ?? "",
      chapters: json['chapters'] as int? ?? 0,
    );
  }

  MangaResult getMangaResult() {
    return this;
  }

  void printMangaResult() {
    print("Anime Result: ");
    print("id: " + id.toString());
    print("title: " + title);
    print("averageScore: " + averageScore.toString());
    print("coverImage: " + coverImage);
    print("chapters: " + chapters.toString());
    print("status: " + status);
  }
}