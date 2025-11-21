import 'package:dlyl_alsham_dashboard/core/services/phone_call_service.dart';
import 'package:dlyl_alsham_dashboard/core/utils/colors_manager.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/entities/job_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/components/contact_button_card.dart';
import '../../../../../../../core/services/contact_launcher_service.dart';
import '../../../../../../../core/utils/assets_manager.dart';

class JobManagementCard extends StatelessWidget {
  final JobEntity entity;
  final VoidCallback onTap;

  const JobManagementCard({
    super.key,
    required this.entity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            elevation: 4,
            color: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: ColorsManager.grey.withValues(alpha: 0.2),
                border: Border.all(color: Colors.grey.shade300, width: 3.w),
              ),
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🔥 Expanded يمنع الـ overflow
                      Expanded(child: _buildUserInfo(context)),

                      SizedBox(width: 10.w),

                      _buildAvatarAndContact(),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  _buildLocationAndDate(context),
                ],
              ),
            ),
          ),

          Positioned(
            top: 14.h,
            left: 12.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                "جديد",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entity.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.4,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 4.h),

        Text(
          entity.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            height: 1.4,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationAndDate(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 16.sp, color: ColorsManager.primaryColor),
        SizedBox(width: 4.w),

        Expanded(
          child: Text(
            entity.location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),

        SizedBox(width: 10.w),

        Icon(Icons.access_time_rounded, size: 16.sp, color: ColorsManager.primaryColor),
        SizedBox(width: 4.w),

        Text(
          entity.createdAt.toString().substring(0, 10),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarAndContact() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 1.w),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Image.asset(AssetsManager.person, height: 50.h, width: 50.w),
          ),
        ),
        SizedBox(height: 8.h),

        Row(
          children: [
            ContactButtonCard(
              image: AssetsManager.phoneCall,
              onTap: () => PhoneCallService.callNumber(entity.phone),
            ),
            SizedBox(width: 8.w),
            ContactButtonCard(
              image: AssetsManager.whatsapp,
              onTap: () => ContactLauncherService.openWhatsApp(entity.phone),
            ),
          ],
        ),
      ],
    );
  }
}
