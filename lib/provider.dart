import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/ranking.dart';
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
final runAwayTextFlagProvider = StateProvider<bool>((ref) => false);
final evolutionFlagProvider = StateProvider<bool>((ref) => false);

final bgmAudioProvider = Provider<Audio>((ref) => Audio());
final explosionAudioProvider = Provider<Audio>((ref) => Audio());
final attackBgmProvider = Provider<Audio>((ref) => Audio());
final getItemBgmProvider = Provider<Audio>((ref) => Audio());
final kiAudioProvider = Provider<Audio>((ref) => Audio());

final enemyCounterProvider = StateProvider<int>((ref) => 0);
final speedProvider = StateProvider<double>((ref) => 600);
final timeProvider = StateProvider<double>((ref) => 1.2);
final bgmSpeedProvider = StateProvider<double>((ref) => 1);
final deathblowCountProvider = StateProvider<int>((ref) => 0);
final playCountProvider = StateProvider<int>((ref) => 0);
final rankingListProvider = StateProvider<List<Ranking>>((ref) => []);

class UserDataNotifier extends StateNotifier<UserData> {
  UserDataNotifier()
      : super(UserData(name: '', scoreList: [], language: LanguageList.USA));

  // ユーザーデータを更新するメソッド
  void updateUserData(UserData newUserData) {
    state = newUserData;
  }

  LanguageList get name => state.language;
}

final userDataProvider =
    StateNotifierProvider<UserDataNotifier, UserData>((ref) {
  return UserDataNotifier();
});
