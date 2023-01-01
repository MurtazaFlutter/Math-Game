import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Habits extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback settingsTaped;
  final int timeSpend;
  final int timeGoal;
  final bool habitStarted;

  final String habitName;
  const Habits({
    super.key,
    required this.habitName,
    required this.onTap,
    required this.settingsTaped,
    required this.timeSpend,
    required this.timeGoal,
    required this.habitStarted,
  });

  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);

    if (secs.length == 1) {
      secs = '0$secs';
    }

    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }

    return '$mins:$secs';
  }

  double percentageCompleted() {
    return timeSpend / (timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25,
        top: 25,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onTap,
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Stack(
                          children: [
                            CircularPercentIndicator(
                              radius: 30.0,
                              percent: percentageCompleted() < 1
                                  ? percentageCompleted()
                                  : 1,
                              progressColor: percentageCompleted() > 0.5
                                  ? (percentageCompleted() > 0.75
                                      ? Colors.green
                                      : Colors.orange)
                                  : Colors.red,
                            ),
                            Center(
                              child: Icon(
                                habitStarted ? Icons.pause : Icons.play_arrow,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habitName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${formatToMinSec(timeSpend)}/$timeGoal = ${(percentageCompleted() * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: settingsTaped,
              child: const Icon(
                Icons.settings,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
