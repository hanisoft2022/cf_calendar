import 'package:calendar_scheduler/practice%20calendar/d_schedule%20bottom%20sheet/provider/bottom_sheet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OnTapToChangeColor = void Function(int colorHexCode);

class WCategories extends ConsumerWidget {
  final int selectedColorHexCode;
  final OnTapToChangeColor onTapToChangeColor;

  const WCategories({
    super.key,
    required this.selectedColorHexCode,
    required this.onTapToChangeColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryColorsAsync = ref.watch(categoryColorsProvider);

    return categoryColorsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text("에러 발생: $error"),
      ),
      data: (colors) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: colors.map((e) {
            return Row(children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                      onTap: () => onTapToChangeColor(e.id),
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(int.parse('FF${e.color}', radix: 16)),
                            shape: BoxShape.circle,
                            border: e.id == selectedColorHexCode ? Border.all(color: Colors.black, width: 3) : null,
                          ))))
            ]);
          }).toList(),
        );
      },
    );
  }
}
