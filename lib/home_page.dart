// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'subject.dart';
import 'database_helper.dart';
import 'timer_provider.dart';
import 'study_progress_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Subject> subjects = [];

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  _loadSubjects() async {
    subjects = await DatabaseHelper.instance.getSubjects();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GATE Study Tracker"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(subjects[index].name),
                  subtitle: Text(
                      'Time Spent: ${subjects[index].timeSpent ~/ 60} hrs ${subjects[index].timeSpent % 60} mins'),
                  onTap: () {
                    // Set the selected subject for timer
                    Provider.of<TimerProvider>(context, listen: false).selectedSubjectId = subjects[index].id - 1;
                  },
                );
              },
            ),
          ),
          StudyProgressChart(subjects: subjects),
          TimerWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewSubject,
        child: Icon(Icons.add),
      ),
    );
  }

  _addNewSubject() {
    showDialog(
      context: context,
      builder: (context) {
        String newSubjectName = '';
        return AlertDialog(
          title: Text("Add New Subject"),
          content: TextField(
            onChanged: (value) {
              newSubjectName = value;
            },
            decoration: InputDecoration(hintText: "Subject Name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newSubjectName.isNotEmpty) {
                  DatabaseHelper.instance.addSubject(Subject(name: newSubjectName, timeSpent: 0));
                  _loadSubjects();
                  Navigator.of(context).pop();
                }
              },
              child: Text("Add"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
