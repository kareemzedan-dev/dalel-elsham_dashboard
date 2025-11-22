import 'package:dlyl_alsham_dashboard/config/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/project_display_section_entity.dart';
import '../manager/project_display_section_view_model/add_project_display_section_view_model/add_project_display_section_view_model.dart';
import '../manager/project_display_section_view_model/add_project_display_section_view_model/add_project_display_section_view_model_states.dart';

class AddSectionSheet extends StatefulWidget {
  const AddSectionSheet({super.key});

  @override
  State<AddSectionSheet> createState() => _AddSectionSheetState();
}

class _AddSectionSheetState extends State<AddSectionSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController orderController = TextEditingController();

  // تحويل الأرقام العربية إلى إنجليزية
  String normalizeNumbers(String value) {
    return value
        .replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "إضافة قسم جديد",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 20.h),

          /// Title field
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "اسم القسم",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),

          SizedBox(height: 15.h),

          /// Order field
          TextField(
            controller: orderController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "ترتيب القسم (اختياري)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          BlocConsumer<
              AddProjectDisplaySectionViewModel,
              AddProjectDisplaySectionViewModelStates>(
            listener: (context, state) {
              if (state is AddProjectDisplaySectionViewModelSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesManager.home,
                      (route) => false,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("تم إنشاء قسم جديد بنجاح"),
                    backgroundColor: Colors.green,
                  ),
                );
              }

              if (state is AddProjectDisplaySectionViewModelError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },

            builder: (context, state) {
              final loading =
              state is AddProjectDisplaySectionViewModelLoading;

              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading
                      ? null
                      : () {
                    final title = titleController.text.trim();
                    if (title.isEmpty) return;

                    /// --- Parse order correctly ---
                    final raw = orderController.text.trim();
                    final normalized = normalizeNumbers(raw);
                    final int order = int.tryParse(normalized) ?? 1;

                    context
                        .read<AddProjectDisplaySectionViewModel>()
                        .addProjectDisplaySection(
                      ProjectDisplaySectionEntity(
                        id: const Uuid().v4(),
                        title: title,
                        order: order,
                        isActive: true,
                        createdAt: DateTime.now(),
                      ),
                    );
                  },
                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    "إضافة",
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
