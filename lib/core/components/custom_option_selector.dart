import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors_manager.dart';

class CustomOptionSelector extends StatefulWidget {
  final List<String> options;              // 👈 النصوص اللي هتتعرض
  final Function(String) onSelect;         // 👈 لما المستخدم يختار قيمة
  final String? initialValue;              // 👈 قيمة ابتدائية اختيارية

  const CustomOptionSelector({
    super.key,
    required this.options,
    required this.onSelect,
    this.initialValue,
  });

  @override
  State<CustomOptionSelector> createState() => _CustomOptionSelectorState();
}

class _CustomOptionSelectorState extends State<CustomOptionSelector> {
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialValue ?? widget.options.first; // 👈 أول عنصر لو مفيش قيمة مبدئية
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      children: widget.options.map((item) {
        final bool isActive = selected == item;

        return GestureDetector(
          onTap: () {
            setState(() {
              selected = item;
            });
            widget.onSelect(item);
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isActive
                    ? ColorsManager.primaryColor
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isActive
                      ? ColorsManager.primaryColor
                      : Colors.grey.shade400,
                ),
              ),
              child: Text(
                item,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black87,
                  fontSize: 14.sp,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
