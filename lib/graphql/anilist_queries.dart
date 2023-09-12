class AnilistQueries {
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

  static String mediaQuery = r'''
    query mediaQuery($query: String!, $type: MediaType!) {
      page: Page {
        media(search: $query, type: $type, isAdult: false) {
          id
          type
          title {
            userPreferred
            native
            romaji
            english
          }
          coverImage {
            extraLarge
          }
          description
          genres
          averageScore
          status
          episodes
          chapters
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
        }
      }
    }
  ''';

  static String userMediaListQuery = r'''
    query userMediaListQuery($userId: Int!, $type: MediaType!, $status: MediaListStatus!) {
      MediaListCollection(userId: $userId, type: $type, status: $status) {
        lists {
          entries {
            id
            mediaId
            status
            score
            progress
            media {
              id
              type
              title {
                userPreferred
                native
                romaji
                english
              }
              coverImage {
                extraLarge
              }
              description
              genres
              averageScore
              status
              episodes
              chapters
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
}