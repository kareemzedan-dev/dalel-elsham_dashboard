import 'dart:typed_data';
import 'package:dlyl_alsham_dashboard/core/components/custom_button.dart';
import 'package:dlyl_alsham_dashboard/core/components/custom_text_field.dart';
import 'package:dlyl_alsham_dashboard/core/helper/pick_image_source_sheet.dart';
import 'package:dlyl_alsham_dashboard/core/services/image_picker_service.dart';
import 'package:dlyl_alsham_dashboard/core/services/image_upload_service.dart';
import 'package:dlyl_alsham_dashboard/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../config/routes/routes_manager.dart';
import '../../domain/entities/category_entity.dart';
import '../manager/categories/update_category_view_model/update_category_view_model.dart';
import '../manager/categories/update_category_view_model/update_category_view_model_states.dart';

class EditCategorySheet extends StatefulWidget {
  final CategoryEntity category;

  const EditCategorySheet({super.key, required this.category});

  @override
  State<EditCategorySheet> createState() => _EditCategorySheetState();
}

class _EditCategorySheetState extends State<EditCategorySheet> {
  late TextEditingController nameController;
  Uint8List? newImageBytes;
  String? newImageUrl;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.category.name);
    super.initState();
  }

  Future<void> pickImage() async {
    final choice = await showImageSourcePicker(context);
    if (choice == null) return;

    final picker = ImagePickerService();

    final result = choice == "gallery"
        ? await picker.pickFromGallery()
        : await picker.pickFromCamera();

    if (!result.isEmpty) {
      setState(() => newImageBytes = result.bytes);

      /// رفع الصورة
      final uploader = ImageUploadService();
      newImageUrl = await uploader.uploadImage(
        bytes: result.bytes!,
        bucket: "categories",
        folder: "images",
      );
      setState(() {});
    }
  }

  void deleteImage() {
    newImageBytes = null;
    newImageUrl = null;
    setState(() {});
  }

  void save() {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يجب إدخال اسم الفئة"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final updated = CategoryEntity(
      id: widget.category.id,
      name: nameController.text.trim(),
      imageUrl: newImageUrl ?? widget.category.imageUrl,
      order: widget.category.order,
      isActive: widget.category.isActive,
      createdAt: widget.category.createdAt,
    );

    context.read<UpdateCategoryViewModel>().updateCategory(updated);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCategoryViewModel, UpdateCategoryViewModelStates>(
      listener: (context, state) {
        if (state is UpdateCategoryViewModelSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, RoutesManager.home, (route) => false,);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("✔ تم تحديث الفئة بنجاح"),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is UpdateCategoryViewModelError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("❌ خطأ: ${state.message}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },

      child: Container(
        padding: EdgeInsets.all(16.w),
        height: 470.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("تعديل الفئة",
                style:
                TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.h),

            /// اسم الفئة
            CustomTextFormField(
              textEditingController: nameController,
              hintText: "اسم الفئة",
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20.h),

            /// صورة الفئة
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 160.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: newImageBytes != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.memory(newImageBytes!, fit: BoxFit.cover),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    widget.category.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10.h),


            const Spacer(),

            BlocBuilder<UpdateCategoryViewModel, UpdateCategoryViewModelStates>(
              builder: (context, state) {
                final isLoading = state is UpdateCategoryViewModelLoading;

                return CustomButton(
                  text: isLoading ? "جاري الحفظ..." : "حفظ التعديلات",
                  onPressed: isLoading ? null : save,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
