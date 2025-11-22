import 'dart:typed_data';
import 'package:dlyl_alsham_dashboard/core/components/custom_button.dart';
import 'package:dlyl_alsham_dashboard/core/components/custom_text_field.dart';
import 'package:dlyl_alsham_dashboard/core/helper/pick_image_source_sheet.dart';
import 'package:dlyl_alsham_dashboard/core/services/image_picker_service.dart';
import 'package:dlyl_alsham_dashboard/core/services/image_upload_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/dalel_al_sham_place_model.dart';
import '../manager/add_place_view_model/add_place_view_model.dart';
import '../manager/add_place_view_model/add_place_view_model_states.dart';

class AddPlaceSheet extends StatefulWidget {
  const AddPlaceSheet({super.key});

  @override
  State<AddPlaceSheet> createState() => _AddPlaceSheetState();
}

class _AddPlaceSheetState extends State<AddPlaceSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mapLinkController = TextEditingController();

  final List<Uint8List> imageBytesList = [];
  final List<String> uploadedImages = [];

  Future<void> pickImages() async {
    final source = await showImageSourcePicker(context);
    if (source == null) return;

    final picker = ImagePickerService();

    /// اختيار من المعرض → صورة واحدة فقط
    if (source == "gallery") {
      final result = await picker.pickFromGallery();
      if (!result.isEmpty) {
        setState(() {
          imageBytesList.add(result.bytes!);
        });
      }
    }
    else {
      /// كاميرا – صورة واحدة
      final result = await picker.pickFromCamera();
      if (!result.isEmpty) {
        setState(() {
          imageBytesList.add(result.bytes!);
        });
      }
    }
  }


  Future<void> uploadAllImages() async {
    uploadedImages.clear();
    final uploader = ImageUploadService();

    for (var bytes in imageBytesList) {
      final url = await uploader.uploadImage(
        bytes: bytes,
        bucket: "dalel_al_sham",
        folder: "places",
      );

      uploadedImages.add(url!);
    }
  }

  void submit() async {
    if (nameController.text.isEmpty ||
        descController.text.isEmpty ||
        imageBytesList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يجب إدخال جميع البيانات المطلوبة"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    /// رفع كل الصور
    await uploadAllImages();

    /// تجهيز البيانات

    context.read<AddPlaceViewModel>().addPlace(
      DalelAlShamPlaceModel(
        id: const Uuid().v4(),
        name: nameController.text.trim(),
        description: descController.text.trim(),
        addressText: addressController.text.trim(),
        phone: phoneController.text.trim(),
        mapLink: mapLinkController.text.trim(),
        images: uploadedImages,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPlaceViewModel, AddPlaceViewModelStates>(
      listener: (context, state) {
        if (state is AddPlaceViewModelSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("✔ تم إضافة المكان بنجاح"),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is AddPlaceViewModelError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 20.h,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "إضافة مكان جديد",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),

              CustomTextFormField(
                hintText: "اسم المكان",
                textEditingController: nameController,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 12.h),

              CustomTextFormField(
                hintText: "الوصف",
                textEditingController: descController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
              SizedBox(height: 12.h),

              CustomTextFormField(
                hintText: "العنوان",
                textEditingController: addressController,
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(height: 12.h),

              CustomTextFormField(
                hintText: "رقم الهاتف",
                textEditingController: phoneController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 12.h),

              CustomTextFormField(
                hintText: "رابط الخريطة",
                textEditingController: mapLinkController,
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 20.h),

              Text("الصور", style: TextStyle(fontSize: 16.sp)),
              SizedBox(height: 10.h),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  GestureDetector(
                    onTap: pickImages,
                    child: Container(
                      height: 80.h,
                      width: 80.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(Icons.add, size: 30.sp, color: Colors.grey),
                    ),
                  ),

                  ...imageBytesList.map(
                    (bytes) => Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.memory(
                            bytes,
                            height: 80.h,
                            width: 80.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 3,
                          right: 3,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                imageBytesList.remove(bytes);
                              });
                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.red,
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              BlocBuilder<AddPlaceViewModel, AddPlaceViewModelStates>(
                builder: (context, state) {
                  final isLoading = state is AddPlaceViewModelLoading;

                  return CustomButton(
                    text: isLoading ? "جاري الرفع..." : "إضافة",
                    onPressed: isLoading ? null : submit,
                  );
                },
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
