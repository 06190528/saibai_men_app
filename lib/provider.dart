import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/langage.dart';
import 'package:saibai_men_app/common/userData.dart';
import 'package:saibai_men_app/logic/audio.dart';
import 'package:saibai_men_app/ui/gameUi.dart';

final dinoGameProvider =
    StateNotifierProvider<DinoGameNotifier, DinoGame>((ref) {
  return DinoGameNotifier();
});

final showResultDialog = StateProvider<bool>((ref) => false);
final isGameActiveProvider = StateProvider<bool>((ref) => false);
final createStartButtonFlag = StateProvider<bool>((ref) => true);
final pauseProvider = StateProvider<bool>((ref) => false);
final loadingRewardAdProvider = StateProvider<bool>((ref) => false);
final usedContinueProvider = StateProvider<bool>((ref) => false);

final bgmAudioProvider = Provider<Audio>((ref) => Audio());
final explosionAudioProvider = Provider<Audio>((ref) => Audio());
final attackBgmProvider = Provider<Audio>((ref) => Audio());

final enemyCounterProvider = StateProvider<int>((ref) => 0);
final speedProvider = StateProvider<double>((ref) => 600);
final timeProvider = StateProvider<double>((ref) => 1);
final bgmSpeedProvider = StateProvider<double>((ref) => 1);
final deathblowCountProvider = StateProvider<int>((ref) => 0);

final userDataProvider = StateProvider<UserData>((ref) => UserData(
      name: '',
      scoreList: [],
      langage: LangageList.Japan,
    ));
