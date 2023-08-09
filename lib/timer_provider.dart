import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  int minute = 1;
  int second = 0;
  bool isPlaying = false;
  late Timer timer;

  void startTimer() {
    if (!isPlaying) {
      isPlaying = true;
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (second > 0) {
          second--;
        } else {
          if (minute > 0) {
            minute--;
            second = 59;
          } else {
            timer.cancel();
            isPlaying = false;
          }
        }
        notifyListeners();
      });
    }
  }
  void stopTimer() {
    if (isPlaying) {
      timer.cancel();
      isPlaying = false;
      notifyListeners();
    }
  }

  void resetTimer() {
    if (isPlaying) {
      timer.cancel();
      isPlaying = false;
    }
    minute = 1;
    second = 0;
    notifyListeners();
  }
}