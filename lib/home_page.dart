import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_tracker/utils/habits.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List habitList = [
    ['Exercise', false, 0, 10],
    ['Code', false, 0, 20],
    ['Food', false, 0, 20],
    ['Read', false, 0, 40]
  ];

  void habitStarted(int index) {
    var startTime = DateTime.now();
    int elapsedTime = habitList[index][2];
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    if (habitList[index][1]) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          //check when the user has stoped the timer
          if (habitList[index][1] == false) {
            timer.cancel();
          }

          var currentTime = DateTime.now();
          habitList[index][2] = elapsedTime +
              currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void settingOpened(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Setting for ' + habitList[index][0]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Consistency is key',
        ),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (context, index) {
          return Habits(
            habitName: habitList[index][0],
            onTap: (() {
              habitStarted(index);
            }),
            settingsTaped: (() {
              settingOpened(index);
            }),
            timeSpend: habitList[index][2],
            timeGoal: habitList[index][3],
            habitStarted: habitList[index][1],
          );
        },
      ),
    );
  }
}
