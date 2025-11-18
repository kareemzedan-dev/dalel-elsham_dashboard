import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/colors_manager.dart';

class BannerImagesSection extends StatelessWidget {
  final List<String> images;

  const BannerImagesSection({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("صور المشروع"),
        SizedBox(height: 10.h),

        SizedBox(
          height: 140.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...images.map((e) => Container(
                margin: EdgeInsets.only(right: 10.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(e, width: 200.w, fit: BoxFit.cover),
                ),
              )),
              _addButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.primaryColor,
      ),
    );
  }

  Widget _addButton() {
    return Container(
      width: 120.w,
      decoration: BoxDecoration(
        color: ColorsManager.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(Icons.add, size: 26.sp),
    );
  }
}
