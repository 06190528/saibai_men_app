import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/userData.dart';
import 'package:saibai_men_app/provider.dart';

class UserSettingsDialog extends ConsumerWidget {
  const UserSettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // ユーザーデータを取得
    UserData userData = ref.watch(userDataProvider);

    // TextEditingControllerを作成して、初期値を設定
    TextEditingController nameController =
        TextEditingController(text: userData.name);

    // 現在選択されている言語をStateProviderで管理
    final selectedLangageProvider =
        StateProvider<LanguageList>((ref) => userData.language);

    return SizedBox(
      width: width * 0.7,
      height: height * 0.7,
      child: AlertDialog(
        title: Text(Language().translationUserSetting(userData.language)), // 設定
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: Language().translationName(userData.language)),
            ),
            Consumer(
              builder: (context, ref, _) {
                LanguageList selectedLangage =
                    ref.watch(selectedLangageProvider);
                return DropdownButton<LanguageList>(
                  value: selectedLangage,
                  onChanged: (LanguageList? newValue) {
                    if (newValue != null) {
                      ref.read(selectedLangageProvider.notifier).state =
                          newValue;
                    }
                  },
                  items: LanguageList.values.map((LanguageList language) {
                    return DropdownMenuItem<LanguageList>(
                      value: language,
                      child: Text(langageNames[language] ??
                          language.toString().split('.').last),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('キャンセル'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(Language().translationSave(userData.language)), //保存
            onPressed: () async {
              // userDataProviderを更新
              ref.read(userDataProvider.notifier).state = UserData(
                name: nameController.text,
                language: ref.read(selectedLangageProvider),
                scoreList: userData.scoreList, // 既存のスコアリストを保持
              );
              await UserDataService()
                  .saveUserDataToLocal(ref.read(userDataProvider).toMap());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
