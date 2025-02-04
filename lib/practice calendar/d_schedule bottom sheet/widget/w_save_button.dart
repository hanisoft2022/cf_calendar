// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:calendar_scheduler/practice%20calendar/0_common/constant/color.dart';
import 'package:flutter/material.dart';

class WSaveButton extends StatelessWidget {
  final VoidCallback onSaveButtonPressed;

  const WSaveButton({
    super.key,
    required this.onSaveButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor.withOpacity(0.5),
          foregroundColor: Colors.white,
        ),
        onPressed: onSaveButtonPressed,
        child: const Text('저장'),
      ),
    );
  }
}
