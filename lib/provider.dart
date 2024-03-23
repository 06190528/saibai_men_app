import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/ranking.dart';
import 'package:saibai_men_app/common/data/userData.dart';
import 'package:saibai_men_app/logic/audio.dart';
import 'package:saibai_men_app/ui/gameUi.dart';

final dinoGameProvider =
    StateNotifierProvider<DinoGameNotifier, DinoGame>((ref) {
  return DinoGameNotifier();
});

final showResultDialogProvider = StateProvider<bool>((ref) => false);
final isGameActiveProvider = StateProvider<bool>((ref) => false);
final createStartButtonFlag = StateProvider<bool>((ref) => true);
final pauseProvider = StateProvider<bool>((ref) => false);
final isLoadingProvider = StateProvider<bool>((ref) => false);
final usedContinueProvider = StateProvider<bool>((ref) => false);
final swipeFlagProvider = StateProvider<bool>((ref) => false);
final feverFlagProvider = StateProvider<bool>((ref) => false);
final gameClearFlagProvider = StateProvider<bool>((ref) => false);

final bgmAudioProvider = Provider<Audio>((ref) => Audio());
final explosionAudioProvider = Provider<Audio>((ref) => Audio());
final goatSoundsProvider = Provider<Audio>((ref) => Audio());
final attackBgmProvider = Provider<Audio>((ref) => Audio());
final feverBgmProvider = Provider<Audio>((ref) => Audio());

final enemyCounterProvider = StateProvider<int>((ref) => 0);
final feverCountProvider = StateProvider<int>((ref) => 0);
final speedProvider = StateProvider<double>((ref) => 600);
final enemyCreateTimeProvider = StateProvider<double>((ref) => 1.2);
final loadingProgressProvider = StateProvider<double>((ref) => 0);
final bgmSpeedProvider = StateProvider<double>((ref) => 1);
final deathblowCountProvider = StateProvider<int>((ref) => 1);
final userDifficultyLevelProvider = StateProvider<int>((ref) => 0);
final userMaxScoreProvider = StateProvider<int>((ref) => 0);
final userModeProvider = StateProvider<int>((ref) => 0);
final gameModeProvider = StateProvider<int>((ref) => 0);
final userRankingProvider = StateProvider<int>((ref) => 0);
final getCoinCountProvider = StateProvider<int>((ref) => 0);

final rankingListProvider = StateProvider<List<Ranking>>((ref) => []);

class UserDataNotifier extends StateNotifier<UserData> {
  UserDataNotifier()
      : super(UserData(
            name: '', scoreList: [], language: LanguageList.Japan, coin: 0));

  void updateUserData(UserData newUserData, WidgetRef ref) {
    state = newUserData;
    final maxScore = state.scoreList.isNotEmpty
        ? state.scoreList.reduce((curr, next) => curr > next ? curr : next)
        : 0;
    ref.read(userMaxScoreProvider.state).state = maxScore;
  }

  LanguageList get name => state.language;

  void updateUserCoinData(int coin) {
    print('coin: $coin');
    state = UserData(
        name: state.name,
        scoreList: state.scoreList,
        language: state.language,
        coin: coin);
  }
}

final userDataProvider =
    StateNotifierProvider<UserDataNotifier, UserData>((ref) {
  return UserDataNotifier();
});
