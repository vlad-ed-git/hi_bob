abstract class MAudioService {
  Future<void> init();
  Future<void> prepareAudio(String audioName);
  Future<void> playPreparedAudio();
  Future<void> stopPlaying();
  Future<void> dispose();
  Future<void>  playAndRelease(String audioName);
}