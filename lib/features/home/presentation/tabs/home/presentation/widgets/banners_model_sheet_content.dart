import 'dart:typed_data';

import 'package:dlyl_alsham_dashboard/core/components/custom_button.dart';
import 'package:dlyl_alsham_dashboard/core/di/di.dart';
import 'package:dlyl_alsham_dashboard/core/services/image_picker_service.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/entities/banner_entity.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/banners/add_banner_view_model/add_banner_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/banners/add_banner_view_model/add_banner_view_model_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../core/components/custom_option_selector.dart';
import '../../../../../../../core/components/custom_text_field.dart';
import '../../../../../../../core/helper/pick_image_source_sheet.dart';
import '../../../../../../../core/services/image_upload_service.dart';
import '../../../../../../../core/utils/assets_manager.dart';
import '../manager/projects/get_all_projects_view_model/get_all_projects_view_model.dart';
import '../manager/projects/get_all_projects_view_model/get_all_projects_view_model_states.dart';
import '../manager/projects/get_pending_projects_view_model/get_pending_projects_view_model.dart';
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
  Uint8List? bannerBytes;
  String? bannerUrl;
  String linkType = "none";
  String bannerTarget = "home";
  final urlController = TextEditingController();
  String selectedProjectId = "";


  Future<void> _pickBannerImage(BuildContext context) async {
    final choice = await showImageSourcePicker(context);

    if (choice == null) return;

    final picker = ImagePickerService();
    ImagePickerResult res;

    res = (choice == "gallery")
        ? await picker.pickFromGallery(quality: 80)
        : await picker.pickFromCamera(quality: 80);

    if (!res.isEmpty) {
      // عرض الصورة مباشرة
      bannerBytes = res.bytes;

      // رفع الصورة
      final uploader = ImageUploadService();
      final url = await uploader.uploadImage(
        bytes: res.bytes!,
        bucket: "banners",
        folder: "images",
      );

      if (url != null) {
        bannerUrl = url;
        print("🔗 Banner URL: $bannerUrl");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.6,
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
              GestureDetector(
                onTap: () async {
                  await _pickBannerImage(context);
                  (context as Element).markNeedsBuild(); // لتحديث الواجهة
                },
                child: Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: bannerBytes != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.memory(
                      bannerBytes!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                      : Center(
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
              ),

              SizedBox(height: 20.h),
              _buildLabel("اختر نوعيه البانر"),
              SizedBox(height: 8.h),


              CustomOptionSelector(
                options: ["بدون رابط", "داخلي", "خارجي"],
                initialValue: "بدون رابط",
                onSelect: (value) {
                  switch (value) {
                    case "بدون رابط":
                      linkType = "none";
                      break;

                    case "داخلي":
                      linkType = "internal";
                      break;

                    case "خارجي":
                      linkType = "external";
                      break;
                  }

                  print("🔗 Selected Link Type: $linkType");
                },
              ),

              SizedBox(height: 20.h),
              _buildLabel("اذا كان خارجي ادخل الرابط"),
              SizedBox(height: 8.h),
              CustomTextFormField(
                keyboardType: TextInputType.url,
                hintText: "ادخل الرابط",
                textEditingController: urlController,
              ),
              SizedBox(height: 20.h),
              _buildLabel("اذا كان داخلي قم باختيار المشروع المستهدف"),
              SizedBox(height: 8.h),


              BlocProvider(
                create: (context) =>
                getIt<GetAllProjectsViewModel>()
                  ..getAllProjects(),
                child: BlocBuilder<GetAllProjectsViewModel,
                    GetAllProjectsViewModelStates>(
                  builder: (context, state) {
                    if (state is GetAllProjectsViewModelLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is GetAllProjectsViewModelSuccess) {
                      return Container(
                        height: 250.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: ListView.builder(
                          itemCount: state.projects.length,
                          itemBuilder: (context, index) {
                            final project = state.projects[index];
                            final isSelected = selectedProjectId == project.id;

                            return GestureDetector(
                              onTap: () {
                                selectedProjectId = project.id;
                                (context as Element).markNeedsBuild();
                                print("📌 Selected Project: ${project.title}");
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 6.h),
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue.withOpacity(0.10)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.grey.shade300,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            project.title,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            project.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Icon(
                                      isSelected
                                          ? Icons.check_circle
                                          : Icons.arrow_forward_ios_rounded,
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.grey.shade400,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return Container(
                      height: 250.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              _buildLabel("في اي جزء في التطبيق تريد ان يظهر البانر"),
              SizedBox(height: 8.h),
              CustomOptionSelector(
                options: [
                  "دليل الشام",
                  "طلبات العمل",
                  "فرص العمل",
                  "الشاشه الرئيسيه"
                ],
                initialValue: "الشاشه الرئيسيه",
                onSelect: (value) {
                  switch (value) {
                    case "الشاشه الرئيسيه":
                      bannerTarget = "home";
                      break;

                    case "فرص العمل":
                      bannerTarget = "opportunities";
                      break;

                    case "طلبات العمل":
                      bannerTarget = "job_seekers";
                      break;

                    case "دليل الشام":
                      bannerTarget = "dalel_al_sham";
                      break;

                    default:
                      bannerTarget = "";
                  }

                  print("🔥 Banner Target = $bannerTarget");
                },
              ),

              SizedBox(height: 20.h),
              BlocListener<AddBannerViewModel, AddBannerViewModelStates>(
                  listener: (context, state) {

                    if (state is AddBannerViewModelStatesSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("✔ تم إضافة البانر بنجاح"), backgroundColor: Colors.green),
                      );
                      Navigator.pushNamedAndRemoveUntil(context, RoutesManager.home,(route) => false,);
                    }

                    if (state is AddBannerViewModelStatesError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("❌ ${state.message}"), backgroundColor: Colors.red),
                      );
                    }
                  },

                  child: CustomButton(
                    text: "تأكيد",
                    onPressed: () {
                      // -----------------------
                      // VALIDATION
                      // -----------------------
                      if (bannerUrl == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("يجب اختيار صورة البانر")),
                        );
                        return;
                      }

                      if (linkType == "external" && urlController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("يجب إدخال الرابط الخارجي")),
                        );
                        return;
                      }

                      if (linkType == "internal" && selectedProjectId.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("يجب اختيار المشروع المستهدف")),
                        );
                        return;
                      }

                      // -----------------------
                      // BUILD ENTITY
                      // -----------------------
                      final banner = BannerEntity(
                        id: const Uuid().v4(),
                        imageUrl: bannerUrl ?? "",
                        type: linkType, // none | internal | external
                        link: linkType == "external" ? urlController.text.trim() : null,
                        projectId: linkType == "internal" ? selectedProjectId : null,
                        places: [bannerTarget], // home | jobs | job_requests | dalel_alsham
                        isActive: true,
                        order: 0,
                        createdAt: DateTime.now(),
                      );

                      // -----------------------
                      // SEND TO VIEW MODEL
                      // -----------------------
                      context.read<AddBannerViewModel>().addBanner(banner);

                    },
                  ),),

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
