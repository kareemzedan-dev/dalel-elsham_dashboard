import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionButtonsSection extends StatelessWidget {
  final VoidCallback onApprove;
  final VoidCallback onReject;

  /// النصوص المرسلة من الخارج
  final String approveText;
  final String rejectText;

  const ActionButtonsSection({
    Key? key,
    required this.onApprove,
    required this.onReject,
    this.approveText = "موافقة ونشر الإعلان",
    this.rejectText = "رفض / إلغاء الموافقة",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onPressed: onApprove,
              child: Text(
                approveText,
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onPressed: onReject,
              child: Text(
                rejectText,
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
