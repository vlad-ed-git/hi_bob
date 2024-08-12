enum MatchingWordsKeys {
  lessonNumberStorageKey('lastMatchingWordsLessonKey'),
  pageNumberStorageKey('lastMatchingWordsPageInLessonKey'),
  completedLessonsListKey('completedLessonsList');

  const MatchingWordsKeys(this.key);
  final String key;
}

enum MatchingSentencesKeys {
  lastLessonNumberKey('lastRussianEnglishSentencesLessonNumberKey'),
  lastSentenceNumberInLessonKey('lastRussianEnglishSentenceNumberInLessonKey'),
  completedLessonsListKey('completedSentencesLessonsList');

  const MatchingSentencesKeys(this.key);
  final String key;
}
