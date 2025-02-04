import 'package:calendar_scheduler/practice%20calendar/0_common/constant/color.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;
  final Color color;
  final VoidCallback onWScheduleCardTap;

  const WScheduleCard({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.color,
    required this.onWScheduleCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onWScheduleCardTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: primaryColor,
            )),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${startTime.toString().padLeft(2, '0')} : 00',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${endTime.toString().padLeft(2, '0')} : 00',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Expanded(
                child: Text(
                  content,
                ),
              ),
              const Gap(10),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
