import 'package:calendar_scheduler/calendar_type/s_events_calendar.dart';

import 'package:calendar_scheduler/calendar_type/s_range_calendar.dart';
import 'package:calendar_scheduler/calendar_type/s_basic_calendar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SHome extends StatefulWidget {
  const SHome({super.key});

  @override
  SHomeState createState() => SHomeState();
}

class SHomeState extends State<SHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('캘린더 예시'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text('연습'),
              onPressed: () => context.push('/s_practice_calendar'),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              child: const Text('기본'),
              onPressed: () => context.push('/s_basic_calendar'),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: const Text('범위 선택'),
              onPressed: () => context.push('/s_range_calendar'),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: const Text('이벤트'),
              onPressed: () => context.push('/s_events_calendar'),
            ),
          ],
        ),
      ),
    );
  }
}
