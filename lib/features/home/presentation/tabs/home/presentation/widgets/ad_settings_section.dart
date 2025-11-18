import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dlyl_alsham_dashboard/core/utils/colors_manager.dart';

class AdSettingsSection extends StatelessWidget {
  final TextEditingController durationController;
  final String tier;
  final ValueChanged<String?> onTierChanged;
  final bool isActive;
  final ValueChanged<bool> onActiveChanged;

  const AdSettingsSection({
    Key? key,
    required this.durationController,
    required this.tier,
    required this.onTierChanged,
    required this.isActive,
    required this.onActiveChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("مدة الإعلان"),
        _buildDurationField(),
        SizedBox(height: 20.h),

        _buildLabel("نوع الإعلان"),
        _buildTierDropdown(),
        SizedBox(height: 20.h),

        _buildCounterSwitch(),
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

  Widget _buildDurationField() {
    return _buildLabeledTextField("مدة الإعلان (بالأيام)", durationController);
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
      ],
    );
  }

  Widget _buildTierDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: tier,
              items: const [
                DropdownMenuItem(value: "normal", child: Text("عادي")),
                DropdownMenuItem(value: "silver", child: Text("فضي")),
                DropdownMenuItem(value: "gold", child: Text("ذهبي")),
              ],
              onChanged: onTierChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCounterSwitch() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SwitchListTile(
        activeColor: ColorsManager.primaryColor,
        title: const Text("تفعيل عداد المشاهدات"),
        value: isActive,
        onChanged: onActiveChanged,
      ),
    );
  }
}