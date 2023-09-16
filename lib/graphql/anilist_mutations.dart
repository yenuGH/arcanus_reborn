class AnilistMutations {
  static String mediaEntryMutation = r'''
    mutation SaveMediaListEntry(
      $mediaId: Int!, 
      $status: MediaListStatus, 
      $score: Float, 
      $progress: Int, 
      $startedAt: FuzzyDateInput!, 
      $completedAt: FuzzyDateInput!) {
        SaveMediaListEntry(
        mediaId: $mediaId, 
        status: $status, 
        score: $score, 
        progress: $progress, 
        startedAt: $startedAt, 
        completedAt: $completedAt) {
          id
          status
          score
          progress
          startedAt {
            year
            month
            day
          }
          completedAt {
            year
            month
            day
          }
        }
    }
  ''';
}