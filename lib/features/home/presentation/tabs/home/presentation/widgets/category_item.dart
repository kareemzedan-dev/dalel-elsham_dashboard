import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/utils/colors_manager.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
    this.optionsMenu,
  });

  final String image, title;
  final VoidCallback onTap;
  final VoidCallback? optionsMenu;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(2.r),
                decoration: const BoxDecoration(
                  color: ColorsManager.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    height: 50.h,
                    width: 50.w,
                  ),
                ),
              ),

              /// زر القائمة للأدمن
              if (optionsMenu != null)
                Positioned(
                  top: -5,
                  right: -5,
                  child: GestureDetector(
                    onTap: optionsMenu,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child:   Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 6.h),

          /// النص بدون Overflow
          SizedBox(
            width: 80.w,
            child: AutoSizeText(
              title,
              maxLines: 1,
              minFontSize: 8,
              maxFontSize: 13,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
