import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewProvider with ChangeNotifier {
  int _reviewCount = 0; // 初期値
  bool _reviewFlag = false; // 新しいフラグ

  int get reviewCount => _reviewCount;
  bool get reviewFlag => _reviewFlag;

  ReviewProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _reviewCount = prefs.getInt('reviewCount') ?? 0;
    _reviewFlag = prefs.getBool('reviewFlag') ?? false;
    notifyListeners();
  }

  Future<void> setReviewCount(int newCount) async {
    _reviewCount = newCount;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('reviewCount', _reviewCount);
  }

  Future<void> setReviewFlag(bool newValue) async {
    _reviewFlag = newValue;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('reviewFlag', _reviewFlag);
  }
}
