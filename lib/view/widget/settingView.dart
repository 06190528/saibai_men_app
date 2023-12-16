import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rush_time_app/provider/langage_provider.dart';
import 'package:rush_time_app/view/widget/setting_menu.dart';

class SettingMenuView extends StatelessWidget {
  const SettingMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    return Positioned(
      right: MediaQuery.of(context).size.width / 2000,
      child: SizedBox(
        // SizedBoxを使用してサイズを指定
        width: MediaQuery.of(context).size.width / 10,
        height: MediaQuery.of(context).size.width / 10,
        child: IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
            size: MediaQuery.of(context).size.width /
                12, // ここではIconButtonのサイズを直接指定しない
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(languageProvider.settingText(),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 22.5)),
                  content: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 3),
                    child: const LanguageSettingMenu(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
