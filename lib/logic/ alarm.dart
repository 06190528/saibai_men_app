import 'package:audioplayers/audioplayers.dart';

final audioPlayer = AudioPlayer();
void startAlarm() {
  // オーディオを再生する
  audioPlayer.play(AssetSource("sounds/目覚まし時計のアラーム.mp3"));
  // ループ再生モードを設定する
  audioPlayer.setReleaseMode(ReleaseMode.loop);
}

void stopAlarm() {
  // オーディオを停止する
  audioPlayer.stop();
}
