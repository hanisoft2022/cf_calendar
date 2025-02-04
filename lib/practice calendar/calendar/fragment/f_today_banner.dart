import 'package:calendar_scheduler/common/constant/color.dart';
import 'package:flutter/material.dart';

class FTodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  final int taskCount;

  const FTodayBanner({
    super.key,
    required this.selectedDay,
    required this.taskCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor.withOpacity(0.3),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('${selectedDay.year}. ${selectedDay.month}. ${selectedDay.day}'), Text('일정 $taskCount 개')],
      ),
    );
  }
}
