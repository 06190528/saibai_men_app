import 'package:audioplayers/audioplayers.dart';

class Audio {
  final AudioPlayer _player = AudioPlayer();

  // オーディオファイルを再生する
  Future<void> play(String filePath) async {
    try {
      await _player.play(AssetSource(filePath));
    } catch (e) {
      // エラーハンドリング
      print("Error playing audio: $e");
    }
  }

  // オーディオを一時停止する
  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      // エラーハンドリング
      print("Error pausing audio: $e");
    }
  }

  // オーディオを再開する
  Future<void> resume() async {
    try {
      await _player.resume();
    } catch (e) {
      // エラーハンドリング
      print("Error resuming audio: $e");
    }
  }

  // オーディオを停止し、リソースを開放する
  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (e) {
      // エラーハンドリング
      print("Error stopping audio: $e");
    }
  }

// ループ再生の設定
  void setLoop(bool isLooping) {
    _player.setReleaseMode(isLooping ? ReleaseMode.loop : ReleaseMode.release);
  }

  // 音量を設定する (0.0 から 1.0)
  void setVolume(double volume) {
    _player.setVolume(volume);
  }

  // リソースを解放し、AudioPlayerインスタンスを破棄する
  Future<void> dispose() async {
    try {
      await _player.release();
    } catch (e) {
      // エラーハンドリング
      print("Error releasing audio: $e");
    }
  }

  // 再生速度を設定する
  void setSpeed(double speed) {
    _player.setPlaybackRate(speed);
  }
}
