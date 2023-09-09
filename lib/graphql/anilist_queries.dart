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

  static String userAnimeQuery = r'''
    query getAnimeWatching($userId: Int!, $status: MediaListStatus!) {
      page: Page {
        mediaList(type: ANIME, status: $status) {
          id
          media {
            id
            title {
              userPreferred
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
          }
          status
          score
          progress
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