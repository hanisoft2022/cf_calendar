// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:calendar_scheduler/practice%20calendar/database/drift.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

typedef OnTapToChangeColor = void Function(int colorHexCode);

class WCategories extends StatelessWidget {
  final int selectedColorHexCode;
  final void Function(int colorHexCode) onTapToChangeColor;

  const WCategories({
    super.key,
    required this.selectedColorHexCode,
    required this.onTapToChangeColor,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetIt.I<AppDatabase>().getCategoryColors,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: snapshot.data!
              .map(
                (e) => Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          onTapToChangeColor(e.id);
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(
                              int.parse(
                                'FF${e.color}',
                                radix: 16,
                              ),
                            ),
                            shape: BoxShape.circle,
                            border: e.id == selectedColorHexCode
                                ? Border.all(color: Colors.black, width: 3)
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }
}
