import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/colors_manager.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    super.key,
    required this.title,
    required this.child,
    this.onTap,
    this.onEditTitle,
    this.onDeleteTitle,
    this.onEditOrder,
  });

  final String title;
  final Widget child;
  final Function()? onTap;

  /// حدث التعديل
  final Function(BuildContext context, String newTitle)? onEditTitle;
  final Function(BuildContext context, int newOrder)? onEditOrder;


  /// حدث الحذف
  final Function( BuildContext context,)? onDeleteTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => _showTitleMenu(context),
              child: Text(
                '$title :',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Text(
                "اضافه مشروع",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: ColorsManager.primaryColor,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 8.h),
        child,
      ],
    );
  }

  /// ---------------- BOTTOM SHEET عند الضغط على العنوان ----------------
  void _showTitleMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 5.h,
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              /// تعديل
              ListTile(
                leading: Icon(Icons.edit, color: Colors.blue),
                title: Text("تعديل العنوان"),
                onTap: () {
                  Navigator.pop(context);
                  _showEditTitleDialog(context);
                },
              ),

              /// حذف
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text("حذف القسم"),
                onTap: () {
                  Navigator.pop(context);
                  onDeleteTitle?.call(context);
                },
              ),

              ListTile(
                leading: Icon(Icons.format_list_numbered, color: Colors.orange),
                title: Text("تعديل الترتيب"),
                onTap: () {
                  Navigator.pop(context);
                  _showEditOrderDialog(context);
                },
              ),

            ],
          ),
        );
      },
    );
  }
  void _showEditOrderDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("تعديل ترتيب القسم"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "ادخل رقم الترتيب الجديد",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "إلغاء",
                style: TextStyle(
                  color: ColorsManager.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final newOrder = int.tryParse(controller.text.trim());

                if (newOrder == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("❌ يجب إدخال رقم صحيح"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                Navigator.pop(context);

                /// استدعاء الكول باك وإرسال القيمة الجديدة
                onEditOrder?.call(context, newOrder);
              },
              child: Text(
                "حفظ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  /// ---------------- Dialog تعديل العنوان ----------------
  void _showEditTitleDialog(BuildContext context) {
    final controller = TextEditingController(text: title);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("تعديل العنوان"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "اكتب عنوان جديد",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("إلغاء", style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: ColorsManager.primaryColor,
              ),),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onEditTitle?.call(context,controller.text.trim(),);
              },
              child: Text("حفظ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: ColorsManager.white,
              ),),
            ),
          ],
        );
      },
    );
  }
}
