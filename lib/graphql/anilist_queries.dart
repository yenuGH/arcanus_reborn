class AnilistQueries {
  static String searchAnimeQuery = r'''
    query searchAnime($query: String!) {
      page: Page {
        media(search: $query, type: ANIME, isAdult: false) {
          id
          title {
            userPreferred
            romaji
            english
            native
          }
          description
          genres
          averageScore
          coverImage {
            extraLarge
          }
          episodes
          status
          nextAiringEpisode {
            airingAt
            timeUntilAiring
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