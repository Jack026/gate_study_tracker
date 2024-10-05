// lib/study_progress_chart.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'subject.dart';

class StudyProgressChart extends StatelessWidget {
  final List<Subject> subjects;

  StudyProgressChart({required this.subjects});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxY(),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(showTitles: true),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 4.0,
                  child: Text(
                    subjects[value.toInt()].name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          borderData: FlBorderData(show: true),
          barGroups: subjects.map((subject) {
            return BarChartGroupData(
              x: subject.id,
              barRods: [
                BarRodData(
                  toY: subject.timeSpent.toDouble(),
                  color: Colors.blue,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  double _getMaxY() {
    return subjects.isNotEmpty
        ? subjects.map((subject) => subject.timeSpent.toDouble()).reduce((a, b) => a > b ? a : b) + 60
        : 60; // Add some space above the max value for better visibility
  }
}
