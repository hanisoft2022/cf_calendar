import 'package:calendar_scheduler/calendar_type/s_events_calendar.dart';
import 'package:calendar_scheduler/practice%20calendar/calendar/screen/s_practice_calendar.dart';
import 'package:calendar_scheduler/calendar_type/s_range_calendar.dart';
import 'package:calendar_scheduler/calendar_type/s_basic_calendar.dart';
import 'package:flutter/material.dart';

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
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SPracticeCalendar()),
              ),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              child: const Text('기본'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SBasicCalendar()),
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: const Text('범위 선택'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SRangeCalendar()),
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: const Text('이벤트'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SEventsCalendar()),
              ),
            ),
            // const SizedBox(height: 12.0),
            // ElevatedButton(
            //   child: Text('Multiple Selection'),
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (_) => TableMultiExample()),
            //   ),
            // ),
            // const SizedBox(height: 12.0),
            // ElevatedButton(
            //   child: Text('Complex'),
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (_) => TableComplexExample()),
            //   ),
            // ),
            // const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
