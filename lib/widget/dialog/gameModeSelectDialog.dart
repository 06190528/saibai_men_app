import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/data/userData.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/bannerAndpPadlockWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';

class GameModeSelectDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserData userData = ref.watch(userDataProvider);
    final size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: const EdgeInsets.all(0), // Dialogのデフォルトパディングを削除
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 子ウィジェットのサイズに合わせる
          children: [
            DoubleText(
              text: Language().translationSelectMode(userData.language),
              fontSize: size.width * 0.07,
              insideColor: Color.fromARGB(255, 255, 192, 1),
            ),
            BannerAndPadlockWidget(
              text: Language().translationHard(userData.language),
              padlockScore: modeScore1,
            ),
            SizedBox(height: size.height * 0.03),
            BannerAndPadlockWidget(
              text: Language().translationNormal(userData.language),
              padlockScore: 0,
            ),
          ],
        ),
      ),
    );
  }
}
