import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dlyl_alsham_dashboard/core/utils/colors_manager.dart';

class SocialLinksSection extends StatelessWidget {
  final TextEditingController facebookController;
  final TextEditingController instagramController;
  final TextEditingController websiteController;
  final TextEditingController mapLinkController;

  const SocialLinksSection({
    Key? key,
    required this.facebookController,
    required this.instagramController,
    required this.websiteController,
    required this.mapLinkController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("روابط التواصل"),
        SizedBox(height: 10.h),
        _buildLabeledTextField("رابط فيسبوك", facebookController),
        _buildLabeledTextField("رابط إنستغرام", instagramController),
        _buildLabeledTextField("الموقع الإلكتروني", websiteController),
        _buildLabeledTextField("رابط موقعه علي الخريطه", mapLinkController),
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

  Widget _buildLabeledTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}