import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/common/langage.dart';
import 'package:saibai_men_app/common/userData.dart';
import 'package:saibai_men_app/provider.dart';

class UserSettingsDialog extends ConsumerWidget {
  const UserSettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ユーザーデータを取得
    UserData userData = ref.watch(userDataProvider);

    // TextEditingControllerを作成して、初期値を設定
    TextEditingController nameController =
        TextEditingController(text: userData.name);

    // 現在選択されている言語をStateProviderで管理
    final selectedLangageProvider =
        StateProvider<LangageList>((ref) => userData.langage);

    return AlertDialog(
      title: Text('ユーザー設定'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: '名前'),
          ),
          Consumer(
            builder: (context, ref, _) {
              LangageList selectedLangage = ref.watch(selectedLangageProvider);
              return DropdownButton<LangageList>(
                value: selectedLangage,
                onChanged: (LangageList? newValue) {
                  if (newValue != null) {
                    ref.read(selectedLangageProvider.notifier).state = newValue;
                  }
                },
                items: LangageList.values.map((LangageList langage) {
                  return DropdownMenuItem<LangageList>(
                    value: langage,
                    child: Text(langageNames[langage] ??
                        langage.toString().split('.').last),
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
          child: Text(Langage().translationSave(userData.langage)), //保存
          onPressed: () async {
            // userDataProviderを更新
            ref.read(userDataProvider.notifier).state = UserData(
              name: nameController.text,
              langage: ref.read(selectedLangageProvider),
              scoreList: userData.scoreList, // 既存のスコアリストを保持
            );
            await UserDataService()
                .saveUserDataToLocal(ref.read(userDataProvider).toMap());
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
