import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rush_time_app/provider/langage_provider.dart';

class LanguageSettingMenu extends StatelessWidget {
  const LanguageSettingMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: true);
    return Column(
      // RowからColumnへ変更
      mainAxisAlignment: MainAxisAlignment.center,
      children: Country.values.map((country) {
        return RadioListTile<Country>(
          title: Text(country.toString().split('.').last,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 30)),
          value: country,
          groupValue: languageProvider.selectedCountry,
          onChanged: (Country? newValue) {
            if (newValue != null) {
              languageProvider.setSelectedCountry(newValue);
            }
          },
        );
      }).toList(),
    );
  }
}
