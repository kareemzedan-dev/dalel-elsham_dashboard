import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/entities/project_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../core/utils/colors_manager.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({
    super.key,
    required this.projectEntity,
      this.onDelete,
  });

  final ProjectEntity projectEntity;
  final VoidCallback ? onDelete;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutesManager.projectDetails,
          arguments: {
            "projectId": projectEntity.id,
            "projectName": projectEntity.title,
            "watchCount": projectEntity.views,
          },
        );
      },
      child: Container(
        width: 150.w,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isDark
              ? ColorsManager.grey.withOpacity(0.5)
              : ColorsManager.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: SizedBox(
                    height: 120.h,
                    width: double.infinity,
                    child: Image.network(
                      projectEntity.logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// زر X
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () async {
                      final confirm = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("تأكيد الحذف"),
                          content: const Text(
                            "هل تريد حذف هذا المشروع من هذه المجموعة؟",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("إلغاء"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text(
                                "حذف",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        onDelete!();
                      }
                    },

                    child: onDelete != null ? Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ):null
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            Text(
              projectEntity.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w800, fontSize: 15.sp),
            ),
            SizedBox(height: 4.h),

            Text(
              projectEntity.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 6.h),

            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16.sp,
                  color: ColorsManager.primaryColor,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    projectEntity.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
