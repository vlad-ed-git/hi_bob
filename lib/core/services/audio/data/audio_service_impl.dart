import 'package:audioplayers/audioplayers.dart';
import 'package:hi_bob/core/services/audio/domain/audio_service.dart';

class MAudioServiceImpl implements MAudioService {
  String _getAudioUrl(String audioName) =>
      'https://firebasestorage.googleapis.com/v0/b/hi-bob-4971e.appspot.com/o/audio%2F$audioName.mp3?alt=media';

  AudioPlayer? _audioPlayer;
  @override
  Future<void> init() async {
    _audioPlayer ??= AudioPlayer();
  }

  @override
  Future<void> prepareAudio(String audioName) async {
    try {
      if (_audioPlayer == null) await init();
      await _audioPlayer?.setSource(
        UrlSource(_getAudioUrl(audioName.trim())),
      );
    }catch (e) {
      print('\n|*****************|\n'
          'prepareAudio(String $audioName) got error $e '
          '\n|*****************|\n');
    }
  }

  @override
  Future<void> playAudio() async {
    try{
    await _audioPlayer?.resume();
    }catch (e) {
      print('\n|*****************|\n'
          'playAudio() got error $e '
          '\n|*****************|\n');
    }
  }

  @override
  Future<void> stopPlaying() async {
    try{
    await _audioPlayer?.stop();
    }catch (e) {
      print('\n|*****************|\n'
          'stopPlaying() got error $e '
          '\n|*****************|\n');
    }
  }

  @override
  Future<void> dispose() async {
    try{
    await _audioPlayer?.dispose();
    }catch (e) {
      print('\n|*****************|\n'
          'dispose() got error $e '
          '\n|*****************|\n');
    }
  }
}
