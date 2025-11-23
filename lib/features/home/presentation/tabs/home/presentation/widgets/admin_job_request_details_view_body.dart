import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/job_entity.dart';
import 'action_buttons_section.dart';
import 'job_request_form_fields.dart';
class AdminJobRequestDetailsViewBody extends StatelessWidget {
  const AdminJobRequestDetailsViewBody({
    super.key,
    required this.onTierChanged,   // ← required مش nullable
    required this.job,
    required this.title,
    required this.onApprove,
    required this.onReject,
    required this.titleController,
    required this.locationController,
    required this.phoneController,
    required this.descriptionController,
    required this.durationController,
    required this.selectedTier,
    required this.approveText,
    required this.rejectText,
  });

  final ValueChanged<String?> onTierChanged;  // ← هنا اتحلت
  final JobEntity job;
  final String title;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final String approveText;
  final String rejectText;

  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController phoneController;
  final TextEditingController descriptionController;
  final TextEditingController durationController;

  final String selectedTier;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            JobRequestFormFields(
              controllers: [
                titleController,
                locationController,
                phoneController,
                descriptionController,
                durationController,
              ],
              labels: [
                title,
                "الموقع",
                "رقم الهاتف + واتس آب",
                "الوصف",
                "مدة الإعلان (بالأيام)",
              ],
              hints: [
                "اكتب اسم الوظيفة هنا...",
                "اكتب المنطقة أو العنوان...",
                "مثال: 099999999",
                "اكتب تفاصيل الإعلان...",
                "عدد الأيام",
              ],
              tier: selectedTier,
              onTierChanged: onTierChanged, // ← مظبوطة
            ),

            ActionButtonsSection(
              onApprove: onApprove,
              onReject: onReject,
              approveText: approveText,
              rejectText:  rejectText,
            ),
          ],
        ),
      ),
    );
  }
}
