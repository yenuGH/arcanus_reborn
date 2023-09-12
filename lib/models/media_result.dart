// ignore_for_file: unnecessary_this

import 'package:arcanus_reborn/constants/enums.dart';

class MediaResult {
  int id;
  MediaType mediaType;
  String titleUserPreferred;
  String titleEnglish;
  String titleRomaji;
  String titleNative;
  String description;
  List<String> genres;
  int averageScore;
  String coverImage;
  int episodes;
  int chapters;
  Map<String, dynamic> nextAiringEpisode;
  String status;

  MediaResult({
    required this.id,
    required this.mediaType,
    required this.titleUserPreferred,
    required this.titleEnglish,
    required this.titleRomaji,
    required this.titleNative,
    required this.description,
    required this.genres,
    required this.averageScore,
    required this.coverImage,
    required this.episodes,
    required this.chapters,
    required this.nextAiringEpisode,
    required this.status,
  });

  factory MediaResult.fromJson(Map<String, dynamic> json) {
    MediaResult mediaResult = MediaResult(
      id: json['id'] as int? ?? 0,
      mediaType: json['type'] == "ANIME" ? MediaType.ANIME : MediaType.MANGA,
      titleUserPreferred: json['title']['userPreferred'] as String? ?? "",
      titleEnglish: json['title']['english'] as String? ?? "",
      titleRomaji: json['title']['romaji'] as String? ?? "",
      titleNative: json['title']['native'] as String? ?? "",
      description: json['description'] as String? ?? "",
      genres: List<String>.from(json['genres'] as List<dynamic>? ?? []),
      averageScore: json['averageScore'] as int? ?? 0,
      coverImage: json['coverImage']['extraLarge'] as String? ?? "",
      episodes: json['episodes'] as int? ?? 0,
      chapters: json['chapters'] as int? ?? 0,
      nextAiringEpisode: Map<String, dynamic>.from(json['nextAiringEpisode'] as Map<String, dynamic>? ?? {}),
      status: json['status'] as String? ?? "",
    );

    if (mediaResult.status == "RELEASING") {
      mediaResult.status = "RELEASING";
    }
    else if (mediaResult.status == "FINISHED") {
      mediaResult.status = "FINISHED";
    }
    else if (mediaResult.status == "NOT_YET_RELEASED") {
      mediaResult.status = "UNRELEASED";
    }
    else if (mediaResult.status == "CANCELLED") {
      mediaResult.status = "CANCELLED";
    }
    else if (mediaResult.status == "HIATUS") {
      mediaResult.status = "HIATUS";
    }
    else {
      mediaResult.status = "UNKNOWN";
    }

    return mediaResult;
  }

  MediaResult getAnimeResult() {
    return this;
  }
}