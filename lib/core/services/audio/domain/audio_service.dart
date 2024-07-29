abstract class MAudioService {
  Future<void> init();
  Future<void> prepareAudio(String audioName);
  Future<void> playAudio();
  Future<void> stopPlaying();
  Future<void> dispose();
}