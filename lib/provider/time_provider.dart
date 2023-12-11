import 'package:flutter/material.dart';

class TimeProvider {
  late DateTime firstTime;

  TimeProvider(DateTime now) {
    // 現在の時間に1分加算
    firstTime = now.add(Duration(minutes: 1));
  }

  DateTime getAddedTime(int minutes) {
    DateTime addedTime = firstTime.add(Duration(minutes: minutes));
    return DateTime(addedTime.year, addedTime.month, addedTime.day,
        addedTime.hour, addedTime.minute, 0, 0);
  }
}

class SetTime with ChangeNotifier {
  DateTime? _setedTime;

  // コンストラクタでは時間をセットしない
  SetTime();

  // 時間をセットするメソッド
  void setTime(DateTime setTime) {
    _setedTime = setTime;
    notifyListeners(); // これが重要
    //     "${setedTime.hour.toString().padLeft(2, '0')}:${setedTime.minute.toString().padLeft(2, '0')}";
    // print(formattedTime);
    //print(setedTime); //いけてる
  }

  DateTime getTime() {
    if (_setedTime == null) {
      throw Exception("Time is not set yet");
    }
    print(_setedTime);
    return _setedTime!;
  }
}
