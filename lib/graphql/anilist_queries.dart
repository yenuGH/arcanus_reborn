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
    query searchManga($query: String!) {
      page: Page {
        media(search: $query, type: MANGA, isAdult: false) {
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
          chapters
          status
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

  static String userQuery = r''' 
    query userQuery () {
      Viewer {
        id
        name
        avatar {
          large
          medium
        }
        bannerImage
      }
    }
  ''';

  static String userAnimeQuery = r'''
    query userAnimeQuery($userId: Int!, $status: MediaListStatus!) {
      MediaListCollection(userId: $userId, type: ANIME, status: $status) {
        lists {
          entries {
            id
            mediaId
            status
            score
            progress
            media {
              id
              title {
                userPreferred
              }
              coverImage {
                extraLarge
              }
              status
              episodes
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
          }
        }
      }
    }
  ''';

  static String userMangaQuery = r'''
    query userMangaQuery($userId: Int!, $status: MediaListStatus!) {
      MediaListCollection(userId: $userId, type: MANGA, status: $status) {
        lists {
          entries {
            id
            mediaId
            status
            score
            progress
            media {
              id
              title {
                userPreferred
              }
              coverImage {
                extraLarge
              }
              status
              chapters
              studios(isMain: true) {
                nodes {
                  name
                  isAnimationStudio
                }
              }
              isAdult
            }
          }
        }
      }
    }
  ''';
}