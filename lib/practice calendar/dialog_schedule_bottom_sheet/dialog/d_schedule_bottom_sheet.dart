// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calendar_scheduler/practice%20calendar/database/drift.dart';
import 'package:calendar_scheduler/practice%20calendar/dialog_schedule_bottom_sheet/widget/w_categories.dart';
import 'package:calendar_scheduler/practice%20calendar/dialog_schedule_bottom_sheet/widget/w_save_button.dart';
import 'package:calendar_scheduler/practice%20calendar/dialog_schedule_bottom_sheet/widget/w_start_end_time.dart';
import 'package:calendar_scheduler/practice%20calendar/dialog_schedule_bottom_sheet/widget/w_content.dart';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:get_it/get_it.dart';

class DScheduleBottomSheet extends StatefulWidget {
  final int? id;
  final DateTime selectedDay;

  const DScheduleBottomSheet({super.key, required this.selectedDay, this.id});

  @override
  State<DScheduleBottomSheet> createState() => _DScheduleBottomSheetState();
}

class _DScheduleBottomSheetState extends State<DScheduleBottomSheet> {
  // 시작 시간, 끝나는 시간, content, _category 할당 변수_
  int? _startTime;
  int? _endTime;
  String? _content;
  // 색상 헥스 코드
  late int selectedColorId;

  bool isLoading = true; // 로딩 상태 추가

  // Form에 넣을 Global Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 일정 선택한 경우 카테고리 색상 초기화
  @override
  void initState() {
    super.initState();

    initCategory();
  }

  initCategory() async {
    if (widget.id != null) {
      final resp =
          await GetIt.I<AppDatabase>().getScheduleWithCategoryById(widget.id!);

      setState(() {
        selectedColorId = resp.categoryColor.id;
        isLoading = false; // 로딩 완료
      });
    } else {
      final resp = await GetIt.I<AppDatabase>().getCategoryColors;

      setState(() {
        selectedColorId = resp.first.id;
        isLoading = false; // 로딩 완료
      });
    }
  }

  // start time 콜백함수
  String? _onStartValidate(String? val) {
    if (val == null || val.isEmpty) {
      return '시작 시각을 입력하세요';
    }

    if (int.tryParse(val) == null) {
      return '유효한 숫자를 입력하세요.';
    }

    final time = int.parse(val);
    if (time < 1 || time > 24) {
      return '1~24 사이의 숫자 입력하세요.';
    }
    return null;
  }

  void _onStartSaved(String? val) {
    if (val == null) {
      return;
    }

    _startTime = int.parse(val);
  }

  // end time 콜백함수
  String? _onEndValidate(String? val) {
    if (val == null || val.isEmpty) {
      return '시작 시각을 입력하세요';
    }

    if (int.tryParse(val) == null) {
      return '유효한 숫자를 입력하세요.';
    }

    if (int.parse(val) < 1 || int.parse(val) > 24) {
      return '1~24 사이의 숫자 입력하세요.';
    }
    return null;
  }

  void _onEndSaved(String? val) {
    if (val == null) {
      return;
    }

    _endTime = int.parse(val);
  }

  // content 콜백함수_
  String? _onContentValidate(String? val) {
    if (val == null || val.isEmpty) {
      return '내용을 입력하세요.';
    }

    // if (val.length < 5) {
    //   return '5자 이상 입력해주세요.';
    // }

    return null;
  }

  void _onContentSaved(String? val) {
    if (val == null) {
      return;
    }

    _content = val;
  }

  // save button 콜백 함수
  void _onSaveButtonPressed() async {
    final bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
    }

    final database = GetIt.I<AppDatabase>();

    if (widget.id == null) {
      await database.addSchedule(
        ScheduleItemsCompanion(
          startTime: Value(_startTime!),
          endTime: Value(_endTime!),
          categoryColorId: Value(selectedColorId),
          content: Value(_content!),
          date: Value(widget.selectedDay),
        ),
      );
    } else {
      await database.updateScheduleById(
        widget.id!,
        ScheduleItemsCompanion(
          startTime: Value(_startTime!),
          endTime: Value(_endTime!),
          categoryColorId: Value(selectedColorId),
          content: Value(_content!),
          date: Value(widget.selectedDay),
        ),
      );
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return FutureBuilder(
        future: widget.id == null
            ? null
            : GetIt.I<AppDatabase>().getScheduleWithCategoryById(widget.id!),
        builder: (context, snapshot) {
          final data = snapshot.data?.scheduleItem;

          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            height: 400,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  WStartEndTime(
                    onStartValidate: _onStartValidate,
                    onStartSaved: _onStartSaved,
                    onEndValidate: _onEndValidate,
                    onEndSaved: _onEndSaved,
                    startTimeInitValue: data?.startTime.toString(),
                    endTimeInitValue: data?.endTime.toString(),
                  ),
                  const Gap(20),
                  WContent(
                    onContentValidate: _onContentValidate,
                    onContentSaved: _onContentSaved,
                    initialValue: data?.content,
                  ),
                  const Gap(10),
                  WCategories(
                    selectedColorHexCode: selectedColorId,
                    onTapToChangeColor: (int colorHexCode) {
                      setState(
                        () {
                          selectedColorId = colorHexCode;
                        },
                      );
                    },
                  ),
                  const Gap(10),
                  WSaveButton(
                    onSaveButtonPressed: _onSaveButtonPressed,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
