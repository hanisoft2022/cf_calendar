// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:calendar_scheduler/practice%20calendar/dialog_schedule_bottom_sheet/widget/w_custom_text_form_field.dart';
import 'package:flutter/material.dart';

class WContent extends StatelessWidget {
  final FormFieldValidator<String> onContentValidate;
  final FormFieldSetter<String> onContentSaved;
  final String? initialValue;

  const WContent({super.key, required this.onContentValidate, required this.onContentSaved, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: WCustomTextFormField(
        initialValue: initialValue,
        hintText: '일정 내용',
        validator: onContentValidate,
        onSaved: onContentSaved,
        isExpands: true,
      ),
    );
  }
}
