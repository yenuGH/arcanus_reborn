class AnilistQueries {
  static String searchAnimeQuery = r'''
    query searchAnime($query: String!) {
    page: Page {
      media(search: $query, type: ANIME, isAdult: false) {
        id
        title {
          userPreferred
        }
        averageScore
        coverImage {
          extraLarge
        }
        episodes
        status
        nextAiringEpisode {
          episode
        }
        studios(isMain: true) {
          nodes {
            name
            isAnimationStudio
          }
        }
        isAdult
        mediaListEntry {
          id
          status
          score
          progress
        }
      }
    }
  }
  ''';

  static String searchMangaQuery = r'''
    query searchAnime($query: String!) {
    page: Page {
      media(search: $query, type: MANGA, isAdult: false) {
        id
        title {
          userPreferred
        }
        averageScore
        coverImage {
          extraLarge
        }
        status
        chapters
        isAdult
      }
    }
  }
  ''';
}