import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dlyl_alsham_dashboard/core/utils/colors_manager.dart';

class GallerySection extends StatelessWidget {
  final List<String> images;
  final VoidCallback onAddImage;
  final Function(int) onRemoveImage;

  const GallerySection({
    Key? key,
    required this.images,
    required this.onAddImage,
    required this.onRemoveImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("معرض الصور"),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            ...images.asMap().entries.map(
                  (entry) => Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      entry.value,
                      width: 110.w,
                      height: 110.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: GestureDetector(
                      onTap: () => onRemoveImage(entry.key),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close, color: Colors.white, size: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onAddImage,
              child: Container(
                width: 110.w,
                height: 110.h,
                decoration: BoxDecoration(
                  color: ColorsManager.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.add, size: 26.sp),
              ),
            ),
          ],
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