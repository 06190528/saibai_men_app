enum LangageList {
  USA,
  Japan,
  China,
  Korea,
  France,
  Germany,
  Italy,
  Spain,
}

class Langage {
  LangageList _selectedLanguage;

  Langage(this._selectedLanguage);

  LangageList get currentLanguage => _selectedLanguage;

  void changeLanguage(LangageList newLanguage) {
    _selectedLanguage = newLanguage;
    // ここで通知や他の処理を実装する
  }
}
