// 별도의 파일(ex: schedule_item_widget.dart)로 분리할 수도 있습니다.
import 'package:calendar_scheduler/practice%20calendar/0_common/database/database.dart';

import 'package:flutter/material.dart';
import 'package:calendar_scheduler/practice%20calendar/calendar/widget/w_schedule_card.dart';

// 가정: schedule 데이터 타입은 Schedule, 그리고 categoryColor를 이용해 색상을 전달합니다.
class WScheduleItem extends StatelessWidget {
  final ScheduleItem schedule;
  final Color color;
  final VoidCallback onDismissed;
  final VoidCallback onTap;

  const WScheduleItem({super.key, required this.schedule, required this.color, required this.onDismissed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<int>(schedule.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue[100],
        ),
      ),
      onDismissed: (_) => onDismissed(),
      child: WScheduleCard(
        startTime: schedule.startTime,
        endTime: schedule.endTime,
        content: schedule.content,
        color: color,
        onWScheduleCardTap: onTap,
      ),
    );
  }
}
