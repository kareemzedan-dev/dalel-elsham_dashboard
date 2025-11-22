import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/colors_manager.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({super.key, required this.title, required this.child, this.onTap});

  final String title;
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title :',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold,fontSize: 18.sp),
            ),
            GestureDetector(
              onTap: onTap,
              child: Text(
                "اضافه مشروع",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: ColorsManager.primaryColor,
                ),
              ),
            )

          ],
        ),
        SizedBox(height: 8.h),

        child,
      ],
    );
  }
}
