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

  static String userQuery = r''' 
    query userQuery () {
      Viewer {
        id
        name
        avatar {
          large
          medium
        }
        
      }
    }
  ''';

  static String userAnimeWatchingQuery = r'''
    query userAnimeWatchingQuery($userId: Int!) {
      MediaListCollection(userId: $userId, type: ANIME, status: PLANNING) {
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