enum MatchingWordsKeys{
  lessonNumberStorageKey('lastMatchingWordsLessonKey'),
  pageNumberStorageKey('lastMatchingWordsPageInLessonKey'),
  completedLessonsListKey('completedLessonsList');
  const MatchingWordsKeys(this.key);
  final String key;

}