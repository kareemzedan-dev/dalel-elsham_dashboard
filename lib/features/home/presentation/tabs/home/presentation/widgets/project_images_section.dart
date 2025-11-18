import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dlyl_alsham_dashboard/core/utils/colors_manager.dart';

import '../../../../../../../core/components/project_fullscreen_gallery.dart';

class ProjectImagesSection extends StatelessWidget {
  final List<String> images;
  final VoidCallback onAddImage;

  const ProjectImagesSection({
    Key? key,
    required this.images,
    required this.onAddImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("صور المشروع"),
        SizedBox(height: 10.h),

        SizedBox(
          height: 140.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...images.asMap().entries.map((entry) {
                int index = entry.key;
                String image = entry.value;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProjectFullScreenGallery(
                          images: images,
                          initialIndex: index,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        image,
                        width: 200.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),

              // // زر الإضافة
              // GestureDetector(
              //   onTap: onAddImage,
              //   child: Container(
              //     width: 120.w,
              //     decoration: BoxDecoration(
              //       color: ColorsManager.grey.withOpacity(0.3),
              //       borderRadius: BorderRadius.circular(12.r),
              //     ),
              //     child: Icon(Icons.add, size: 26.sp),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.primaryColor,
      ),
    );
  }
}
