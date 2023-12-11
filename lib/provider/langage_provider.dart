import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Country {
  USA,
  SouthKorea,
  Japan,
  China,
}

class LanguageProvider with ChangeNotifier {
  Country _selectedCountry = Country.Japan; // デフォルトの国

  Country get selectedCountry => _selectedCountry;

  LanguageProvider() {
    _loadLanguageSetting();
  }

  void setSelectedCountry(Country newCountry) async {
    if (_selectedCountry != newCountry) {
      _selectedCountry = newCountry;
      notifyListeners(); // リスナーに変更を通知
      await _saveLanguageSetting();
    }
  }

  Future<void> _loadLanguageSetting() async {
    final prefs = await SharedPreferences.getInstance();
    final countryName = prefs.getString('selectedCountry') ?? 'Japan';
    _selectedCountry = Country.values.firstWhere(
        (c) => c.toString() == 'Country.$countryName',
        orElse: () => Country.Japan);
    notifyListeners();
  }

  Future<void> _saveLanguageSetting() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'selectedCountry', _selectedCountry.toString().split('.').last);
  }

  String aramTiemString() {
    switch (_selectedCountry) {
      case Country.SouthKorea:
        return "알람 시간";
      case Country.Japan:
        return "アラーム時刻";
      case Country.USA:
        return "Alarm time";
      case Country.China:
        return "闹钟时间";
      default:
        return "Alarm time";
    }
  }

  String cancelText() {
    switch (_selectedCountry) {
      case Country.SouthKorea:
        return "취소";
      case Country.Japan:
        return "キャンセル";
      case Country.USA:
        return "cancel";
      case Country.China:
        return "取消";
      default:
        return "cancel";
    }
  }

  String settingText() {
    switch (_selectedCountry) {
      case Country.SouthKorea:
        return "설정";
      case Country.Japan:
        return "設定";
      case Country.USA:
        return "setting";
      case Country.China:
        return "环境";
      default:
        return "setting";
    }
  }

  String timeOutText() {
    switch (_selectedCountry) {
      case Country.SouthKorea:
        return "타임아웃";
      case Country.Japan:
        return "アラーム終了";
      case Country.USA:
        return "time out";
      case Country.China:
        return "暂停";
      default:
        return "time out";
    }
  }

  String stopAram() {
    switch (_selectedCountry) {
      case Country.SouthKorea:
        return "아람을 중지하다";
      case Country.Japan:
        return "アラームを止める";
      case Country.USA:
        return "stop aram";
      case Country.China:
        return "停止阿拉姆";
      default:
        return "stop aram";
    }
  }

  String requestForReview() {
    switch (_selectedCountry) {
      case Country.SouthKorea:
        return "별 5개 리뷰를 주세요！！";
      case Country.Japan:
        return "星５の評価をお願いします！！";
      case Country.USA:
        return "Please give me 5 stars !!";
      case Country.China:
        return "请给我5星评价　！！";
      default:
        return "Please give me 5 stars review!!";
    }
  }
}
