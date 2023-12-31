// ignore_for_file: unnecessary_this

import 'package:arcanus_reborn/constants/enums.dart';

class MediaListResult {
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
  int progress;
  Map<String, dynamic> nextAiringEpisode;
  String status;
  String userStatus;

  MediaListResult({
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
    required this.progress,
    required this.nextAiringEpisode,
    required this.status,
    required this.userStatus,
  });

  factory MediaListResult.fromJson(Map<String, dynamic> json) {
    MediaListResult mediaListResult = MediaListResult(
      id: json['media']['id'] as int? ?? 0,
      mediaType: json['media']['type'] == "ANIME" ? MediaType.ANIME : MediaType.MANGA,
      titleUserPreferred: json['media']['title']['userPreferred'] as String? ?? "",
      titleEnglish: json['media']['title']['english'] as String? ?? "",
      titleRomaji: json['media']['title']['romaji'] as String? ?? "",
      titleNative: json['media']['title']['native'] as String? ?? "",
      description: json['media']['description'] as String? ?? "",
      genres: List<String>.from(json['media']['genres'] as List<dynamic>? ?? []),
      averageScore: json['media']['averageScore'] as int? ?? 0,
      coverImage: json['media']['coverImage']['extraLarge'] as String? ?? "",
      episodes: json['media']['episodes'] as int? ?? 0,
      chapters: json['media']['chapters'] as int? ?? 0,
      progress: json['progress'] as int? ?? 0,
      nextAiringEpisode: Map<String, dynamic>.from(json['media']['nextAiringEpisode'] as Map<String, dynamic>? ?? {}),
      status: json['media']['status'] as String? ?? "",
      userStatus: json['status'] as String? ?? "",
    );

    if (mediaListResult.status == "RELEASING") {
      mediaListResult.status = "RELEASING";
    }
    else if (mediaListResult.status == "FINISHED") {
      mediaListResult.status = "FINISHED";
    }
    else if (mediaListResult.status == "NOT_YET_RELEASED") {
      mediaListResult.status = "UNRELEASED";
    }
    else if (mediaListResult.status == "CANCELLED") {
      mediaListResult.status = "CANCELLED";
    }
    else if (mediaListResult.status == "HIATUS") {
      mediaListResult.status = "HIATUS";
    }
    else {
      mediaListResult.status = "UNKNOWN";
    }

    return mediaListResult;
  }

  MediaListResult getMediaListResult() {
    return this;
  }
}