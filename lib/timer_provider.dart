import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  int minute = 1;
  int second = 0;
  bool isPlaying = false;
  bool isPause = false;  // Biến isPause để kiểm soát trạng thái của nút "Pause"

  late Timer timer;

  void startTimer() {
    if (!isPlaying) {
      isPlaying = true;
     // isPause = false;  // Đặt isPause thành false để hiển thị nút "Pause"
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (second > 0) {
          second--;
        } else {
          if (minute > 0) {
            minute--;
            second = 59;
          } else {
            timer.cancel();
            isPlaying = false;
            isPause = true;  // Khi hết thời gian, đặt isPause thành true để ẩn nút "Pause"
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
      isPause = true;  // Đặt isPause thành true sau khi dừng bộ đếm thời gian
      notifyListeners();
    }
  }

  void togglePlayPauseState() {
    if (isPlaying) {
      stopTimer();
    } else {
      startTimer();
    }
    notifyListeners();
    if (minute == 0 && second == 0) {
      minute = 1;
      second = 0;
    }
  }

  void resetTimer() {
    if (isPlaying) {
      timer.cancel();
      isPlaying = false;
    }
    minute = 1;
    second = 0;
   // isPause = true;  // Đặt isPause thành true sau khi reset để ẩn nút "Pause"
    notifyListeners();
  }
}