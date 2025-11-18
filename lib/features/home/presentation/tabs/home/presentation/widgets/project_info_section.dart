import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dlyl_alsham_dashboard/core/utils/colors_manager.dart';
import '../../../../../../../core/components/custom_text_field.dart';

class ProjectInfoSection extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final TextEditingController phoneController;

  const ProjectInfoSection({
    Key? key,
    required this.titleController,
    required this.locationController,
    required this.descriptionController,
    required this.phoneController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("عنوان المشروع"),
        CustomTextFormField(
          textEditingController: titleController,
          hintText: "",
          keyboardType: TextInputType.name,
        ),
        SizedBox(height: 20.h),

        _buildLabel("الموقع"),
        CustomTextFormField(
          textEditingController: locationController,
          hintText: "",
          keyboardType: TextInputType.name,
        ),
        SizedBox(height: 20.h),

        _buildLabel("رقم الهاتف + واتس اب"),
        CustomTextFormField(
          textEditingController: phoneController,
          hintText: "",
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 20.h),

        _buildLabel("الوصف"),
        CustomTextFormField(
          textEditingController: descriptionController,
          hintText: "",
          maxLines: 5,
          keyboardType: TextInputType.multiline,
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