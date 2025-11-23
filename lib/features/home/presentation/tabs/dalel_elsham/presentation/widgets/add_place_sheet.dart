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
import '../manager/get_all_place_view_model/get_all_place_view_model.dart';
import '../manager/update_place_view_model/update_place_view_model.dart';
import '../manager/update_place_view_model/update_place_view_model_states.dart';

class PlaceFormSheet extends StatefulWidget {
  final DalelAlShamPlaceModel? place; // لو null → add
  final BuildContext parentContext;   // ← إضافة جديدة

  const PlaceFormSheet({super.key, this.place,required  this.parentContext});

  bool get isEdit => place != null;

  @override
  State<PlaceFormSheet> createState() => _PlaceFormSheetState();
}

class _PlaceFormSheetState extends State<PlaceFormSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mapLinkController = TextEditingController();

  /// صور جديدة + صور قديمة
  final List<Uint8List> newImagesBytes = [];
  List<String> oldImages = [];

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      nameController.text = widget.place!.name;
      descController.text = widget.place!.description;
      addressController.text = widget.place!.addressText;
      phoneController.text = widget.place!.phone;
      mapLinkController.text = widget.place!.mapLink ?? "";

      oldImages = List.from(widget.place!.images);
    }
  }

  Future<void> pickImages() async {
    final source = await showImageSourcePicker(context);
    if (source == null) return;

    final picker = ImagePickerService();

    final result = source == "gallery"
        ? await picker.pickFromGallery()
        : await picker.pickFromCamera();

    if (!result.isEmpty) {
      setState(() {
        newImagesBytes.add(result.bytes!);
      });
    }
  }

  /// رفع الصور الجديدة فقط
  Future<List<String>> uploadNewImages() async {
    final uploader = ImageUploadService();
    List<String> uploaded = [];

    for (Uint8List bytes in newImagesBytes) {
      final url = await uploader.uploadImage(
        bytes: bytes,
        bucket: "dalel_al_sham",
        folder: "places",
      );
      uploaded.add(url!);
    }
    return uploaded;
  }

  void submit() async {
    if (nameController.text.isEmpty ||
        descController.text.isEmpty ||
        (oldImages.isEmpty && newImagesBytes.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يجب إدخال جميع البيانات المطلوبة"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final uploadedNewImages = await uploadNewImages();
    final allImages = [...oldImages, ...uploadedNewImages];

    final model = DalelAlShamPlaceModel(
      id: widget.isEdit ? widget.place!.id : const Uuid().v4(),
      name: nameController.text.trim(),
      description: descController.text.trim(),
      addressText: addressController.text.trim(),
      phone: phoneController.text.trim(),
      mapLink: mapLinkController.text.trim(),
      images: allImages,
    );

    if (widget.isEdit) {
      context.read<UpdatePlaceViewModel>().updatePlace(model);
    } else {
      context.read<AddPlaceViewModel>().addPlace(model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [

        /// ========== Listener للإضافة ==========
        BlocListener<AddPlaceViewModel, AddPlaceViewModelStates>(
          listener: (context, state) async {
            if (!widget.isEdit) {
              if (state is AddPlaceViewModelSuccess) {

                /// تحديث الليستة من الأب الحقيقي
                widget.parentContext.read<GetAllPlaceViewModel>().getAllPlaces();

                Navigator.pop(context);

                ScaffoldMessenger.of(widget.parentContext).showSnackBar(
                  const SnackBar(
                    content: Text("✔ تم إضافة المكان بنجاح"),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            }
          },
        ),

        /// ========== Listener للتعديل ==========
        BlocListener<UpdatePlaceViewModel, UpdatePlaceViewModelStates>(
          listener: (context, state) async {
            if (widget.isEdit) {
              if (state is UpdatePlaceViewModelSuccess) {

                widget.parentContext.read<GetAllPlaceViewModel>().getAllPlaces();

                Navigator.pop(context);

                ScaffoldMessenger.of(widget.parentContext).showSnackBar(
                  const SnackBar(
                    content: Text("✔ تم تحديث المكان بنجاح"),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            }
          },
        ),


      ],

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
                widget.isEdit ? "تعديل المكان" : "إضافة مكان جديد",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20.h),

              CustomTextFormField(
                hintText: "اسم المكان",
                textEditingController: nameController,
              ),

              SizedBox(height: 12.h),

              CustomTextFormField(
                hintText: "الوصف",
                textEditingController: descController,
                maxLines: 3,
              ),

              SizedBox(height: 12.h),

              CustomTextFormField(
                hintText: "العنوان",
                textEditingController: addressController,
              ),

              SizedBox(height: 12.h),

              CustomTextFormField(
                hintText: "رقم الهاتف",
                textEditingController: phoneController,
              ),

              SizedBox(height: 12.h),

              CustomTextFormField(
                hintText: "رابط الخريطة",
                textEditingController: mapLinkController,
              ),

              SizedBox(height: 20.h),

              Text("الصور", style: TextStyle(fontSize: 16.sp)),
              SizedBox(height: 10.h),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [

                  /// زر إضافة صورة جديدة
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

                  /// الصور القديمة
                  ...oldImages.map(
                        (url) => Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            url,
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
                                oldImages.remove(url);
                              });
                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.red,
                              child: const Icon(Icons.close,
                                  size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// الصور الجديدة
                  ...newImagesBytes.map(
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
                                newImagesBytes.remove(bytes);
                              });
                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.red,
                              child: const Icon(Icons.close,
                                  size: 16, color: Colors.white),
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
                    text: isLoading
                        ? "جاري الحفظ..."
                        : (widget.isEdit ? "تحديث" : "إضافة"),
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
