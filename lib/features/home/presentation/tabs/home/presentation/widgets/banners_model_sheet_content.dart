import 'package:dlyl_alsham_dashboard/core/components/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/components/custom_option_selector.dart';
import '../../../../../../../core/components/custom_text_field.dart';
import '../../../../../../../core/utils/assets_manager.dart';
import 'form_section_field.dart';

class BannersModelSheetContent extends StatelessWidget {
  BannersModelSheetContent({super.key});

  String? selectedInternalTarget;
  final List<String> internalTargets = [
    "الشاشه الرئيسيه",
    "فرص عمل",
    "طلبات العمل",
    "دليل الشام",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("إضافة بانر جديد"),
              SizedBox(height: 8.h),
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 60.h,
                        width: 60.w,
                        child: Image.asset(
                          AssetsManager.uploadImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      /// 🔥 النص الإضافي
                      Text(
                        "اضغط لاختيار صورة البانر",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),

                      SizedBox(height: 4.h),
                      Text(
                        "الحد الأقصى للحجم 2MB",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              _buildLabel("اختر نوعيه البانر"),
              SizedBox(height: 8.h),

              CustomOptionSelector(
                options: ["بدون رابط", "داخلي", "خارجي"],
                initialValue: "بدون رابط",
                onSelect: (value) {
                  print("اختيار المستخدم: $value");
                },
              ),
              SizedBox(height: 20.h),
              _buildLabel("اذا كان خارجي ادخل الرابط"),
              SizedBox(height: 8.h),
              CustomTextFormField(
                keyboardType: TextInputType.url,
                hintText: "ادخل الرابط",
              ),
              SizedBox(height: 20.h),
              _buildLabel("اذا كان داخلي قم باختيار المشروع المستهدف"),
              SizedBox(height: 8.h),

              Container(
                height: 250.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: SingleChildScrollView(child: Column(children: [])),
              ),
              SizedBox(height: 20.h),
              _buildLabel("في اي جزء في التطبيق تريد ان يظهر البانر"),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                height: 58.h, // 🔥 هيديك شكل موحد مع الـ TextFields
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedInternalTarget,
                    isExpanded: true,
                    hint: Text("اختر المكان"),
                    items: internalTargets.map((target) {
                      return DropdownMenuItem(
                        value: target,
                        child: Text(target),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedInternalTarget = value;
                      print("المشروع المختار: $value");
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomButton(text: "تأكيد", onPressed: () {}),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    );
  }
}
