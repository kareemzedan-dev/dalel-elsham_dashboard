import 'dart:typed_data';
import 'package:dlyl_alsham_dashboard/config/routes/routes_manager.dart';
import 'package:dlyl_alsham_dashboard/core/components/custom_button.dart';
import 'package:dlyl_alsham_dashboard/core/components/custom_text_field.dart';
import 'package:dlyl_alsham_dashboard/core/helper/pick_image_source_sheet.dart';
import 'package:dlyl_alsham_dashboard/core/services/image_picker_service.dart';
import 'package:dlyl_alsham_dashboard/core/services/image_upload_service.dart';
import 'package:dlyl_alsham_dashboard/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/category_entity.dart';
import '../manager/categories/add_category_view_model/add_category_view_model.dart';
import '../manager/categories/add_category_view_model/add_category_view_model_states.dart';
import '../manager/categories/get_all_categories_view_model/get_all_categories_view_model.dart';
import '../manager/categories/get_all_categories_view_model/get_all_categories_view_model_states.dart';

class AddCategorySheet extends StatefulWidget {
  const AddCategorySheet({super.key});

  @override
  State<AddCategorySheet> createState() => _AddCategorySheetState();
}

class _AddCategorySheetState extends State<AddCategorySheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController orderController = TextEditingController();
  Uint8List? imageBytes;
  String? imageUrl;
  bool isUploading = false;

  Future<void> pickImage() async {
    final choice = await showImageSourcePicker(context);
    if (choice == null) return;

    final picker = ImagePickerService();
    final result = choice == "gallery"
        ? await picker.pickFromGallery()
        : await picker.pickFromCamera();

    if (!result.isEmpty) {
      setState(() {
        imageBytes = result.bytes;
        isUploading = true;
      });

      final uploader = ImageUploadService();
      final url = await uploader.uploadImage(
        bytes: result.bytes!,
        bucket: "categories",
        folder: "images",
      );

      setState(() {
        imageUrl = url;
        isUploading = false;
      });
    }
  }

  void submit() {
    if (isUploading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⏳ جاري رفع الصورة... برجاء الانتظار"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (nameController.text.isEmpty || imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يجب إدخال الاسم واختيار صورة"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    /// ⭐ تحديد قيمة الـ order تلقائياً
    int nextOrder = 1;
    final categoriesState = context.read<GetAllCategoriesViewModel>().state;

    if (categoriesState is GetAllCategoriesViewModelSuccess) {
      nextOrder = categoriesState.categories.length + 1;
    }

    final category = CategoryEntity(
      id: const Uuid().v4(),
      name: nameController.text.trim(),
      imageUrl: imageUrl!,
      order: orderController.text.isNotEmpty
          ? int.parse(orderController.text.trim())
          : nextOrder,

      isActive: true,
      createdAt: DateTime.now(),
    );

    context.read<AddCategoryViewModel>().addCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCategoryViewModel, AddCategoryViewModelStates>(
      listener: (context, state) {
        if (state is AddCategoryViewModelSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesManager.home,
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("✔ تم إضافة الفئة بنجاح"),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is AddCategoryViewModelError) {
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
        height: 480.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "إضافة فئة جديدة",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),

            /// اسم الفئة
            CustomTextFormField(
              textEditingController: nameController,
              hintText: "اسم الفئة",
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20.h),
            CustomTextFormField(
              textEditingController: orderController,
              hintText: "رقم ترتيب العنصر",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.h),

            /// صورة الفئة
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: imageBytes != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.memory(imageBytes!, fit: BoxFit.cover),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetsManager.uploadImage, height: 50.h),
                          const SizedBox(height: 8),
                          const Text("اضغط لاختيار صورة"),
                        ],
                      ),
              ),
            ),

            const Spacer(),

            /// زر الإضافة مع BlocBuilder
            BlocBuilder<AddCategoryViewModel, AddCategoryViewModelStates>(
              builder: (context, state) {
                final isLoading = state is AddCategoryViewModelLoading;

                return CustomButton(
                  text: (isLoading || isUploading)
                      ? "جاري الرفع..."
                      : "إضافة",
                  onPressed: (isLoading || isUploading) ? null : submit,
                );
              },
            )

          ],
        ),
      ),
    );
  }
}
