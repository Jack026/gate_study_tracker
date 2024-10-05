// lib/timer_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'timer_provider.dart';

class TimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${(timerProvider.duration ~/ 60).toString().padLeft(2, '0')}:${(timerProvider.duration % 60).toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 48),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: timerProvider.isRunning ? timerProvider.stopTimer : timerProvider.startTimer,
            child: Text(timerProvider.isRunning ? "Stop" : "Start"),
          ),
          ElevatedButton(
            onPressed: timerProvider.resetTimer,
            child: Text("Reset"),
          ),
        ],
      ),
    );
  }
}
