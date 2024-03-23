import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/data/userData.dart';
import 'package:saibai_men_app/provider.dart';

class UserSettingsDialog extends ConsumerWidget {
  const UserSettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    UserData userData = ref.watch(userDataProvider);

    TextEditingController nameController =
        TextEditingController(text: userData.name);

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
            child: Text(Language().translationCancel(userData.language)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(Language().translationSave(userData.language)), //保存
            onPressed: () async {
              ref.read(userDataProvider.notifier).updateUserData(
                  UserData(
                      name: nameController.text,
                      language: ref.read(selectedLangageProvider),
                      scoreList: userData.scoreList,
                      coin: userData.coin),
                  ref);

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
