import 'package:calendar_scheduler/practice%20calendar/d_schedule%20bottom%20sheet/provider/bottom_sheet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:calendar_scheduler/practice%20calendar/d_schedule%20bottom%20sheet/widget/w_start_end_time.dart';
import 'package:calendar_scheduler/practice%20calendar/d_schedule%20bottom%20sheet/widget/w_content.dart';
import 'package:calendar_scheduler/practice%20calendar/d_schedule%20bottom%20sheet/widget/w_categories.dart';
import 'package:calendar_scheduler/practice%20calendar/d_schedule%20bottom%20sheet/widget/w_save_button.dart';

class DScheduleBottomSheet extends ConsumerWidget {
  final DateTime selectedDay;
  final int? id;

  const DScheduleBottomSheet({super.key, required this.selectedDay, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(scheduleFormProvider(id));
    final formNotifier = ref.read(scheduleFormProvider(id).notifier);

    if (formState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 400,
      child: Form(
        key: formNotifier.formKey, // Form 상태 관리를 위한 GlobalKey
        child: Column(
          children: [
            // 시작/종료 시간 위젯 – 내부 WCustomTextFormField를 사용하여 onSaved, validator를 호출
            WStartEndTime(
              startTimeInitValue: formState.startTime?.toString(),
              endTimeInitValue: formState.endTime?.toString(),
              onStartValidate: formNotifier.validateStartTime,
              onEndValidate: formNotifier.validateEndTime,
              onStartSaved: formNotifier.onStartSaved,
              onEndSaved: formNotifier.onEndSaved,
            ),
            const Gap(20),
            // 내용 입력 위젯
            WContent(
              initialValue: formState.content,
              onContentValidate: formNotifier.validateContent,
              onContentSaved: formNotifier.onContentSaved,
            ),
            const Gap(10),
            // 카테고리 선택 위젯 (색상 변화 시 notifier의 업데이트 호출)
            WCategories(
              selectedColorHexCode: formState.selectedColorId,
              onTapToChangeColor: formNotifier.updateSelectedColor,
            ),
            const Gap(10),
            // 저장 버튼 – Form 검증 후 save 그리고 notifier의 저장 로직 호출
            WSaveButton(
              onSaveButtonPressed: () async {
                final currentState = formNotifier.formKey.currentState;
                if (currentState != null && currentState.validate()) {
                  currentState.save();
                  await formNotifier.saveSchedule(selectedDay);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
