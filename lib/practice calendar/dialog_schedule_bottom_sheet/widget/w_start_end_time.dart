// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:calendar_scheduler/practice%20calendar/dialog_schedule_bottom_sheet/widget/w_custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WStartEndTime extends StatelessWidget {
  final FormFieldValidator<String> onStartValidate;
  final FormFieldValidator<String> onEndValidate;
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final String? startTimeInitValue;
  final String? endTimeInitValue;

  const WStartEndTime({
    super.key,
    required this.onStartValidate,
    required this.onEndValidate,
    required this.onStartSaved,
    required this.onEndSaved,
    this.startTimeInitValue,
    this.endTimeInitValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: WCustomTextFormField(
            initialValue: startTimeInitValue,
            hintText: '시작 시각',
            suffixText: '시',
            validator: onStartValidate,
            onSaved: onStartSaved,
          ),
        ),
        const Gap(10),
        Expanded(
          child: WCustomTextFormField(
            initialValue: endTimeInitValue,
            hintText: '끝나는 시각',
            suffixText: '시',
            validator: onEndValidate,
            onSaved: onEndSaved,
          ),
        ),
      ],
    );
  }
}
