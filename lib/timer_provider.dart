// lib/timer_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'subject.dart';
import 'database_helper.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  int _duration = 1500; // 25 minutes
  bool _isRunning = false;
  int selectedSubjectId = -1; // Track the selected subject ID

  int get duration => _duration;
  bool get isRunning => _isRunning;

  void startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_duration > 0) {
        _duration--;
      } else {
        _isRunning = false;
        _timer?.cancel();
        _updateTimeSpent();
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    _duration = 1500; // Reset to 25 minutes
    notifyListeners();
  }

  void _updateTimeSpent() async {
    if (selectedSubjectId != -1) {
      final subject = await DatabaseHelper.instance.getSubjects();
      int newTime = subject[selectedSubjectId].timeSpent + 25; // Add 25 minutes
      DatabaseHelper.instance.updateTimeSpent(selectedSubjectId, newTime);
    }
  }
}
