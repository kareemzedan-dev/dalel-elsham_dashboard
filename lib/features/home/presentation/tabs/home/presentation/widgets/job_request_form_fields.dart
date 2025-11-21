import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/components/custom_text_field.dart';
import '../../../../../../../core/utils/colors_manager.dart';

class JobRequestFormFields extends StatelessWidget {
  const JobRequestFormFields({
    super.key,
    required this.controllers,
    required this.labels,
    required this.hints,
    required this.tier,
    required this.onTierChanged,
  });

  final List<TextEditingController> controllers; // title, location, phone..
  final List<String> labels; // titles of fields
  final List<String> hints; // hints of fields

  final String tier;
  final ValueChanged<String?> onTierChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(controllers.length, (index) {
        // آخر عنصر هو الـ duration
        final isDescription = index == 3;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(labels[index]),
            SizedBox(height: 8.h),
            CustomTextFormField(
              textEditingController: controllers[index],
              hintText: hints[index],
              maxLines: isDescription ? 5 : 1,
              keyboardType: isDescription
                  ? TextInputType.multiline
                  : TextInputType.text,
            ),
            SizedBox(height: 20.h),
          ],
        );
      })
        ..addAll([
          _buildLabel("نوع الإعلان"),
          SizedBox(height: 8.h),
          _buildTierDropdown(),
        ]),
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

  Widget _buildTierDropdown() {
    return Container(
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
    );
  }
}
