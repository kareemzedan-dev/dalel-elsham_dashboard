import 'package:dlyl_alsham_dashboard/config/routes/routes_manager.dart';
import 'package:dlyl_alsham_dashboard/core/components/dismissible_error_card.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/entities/project_entity.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/projects/delete_project_view_model/delete_project_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/projects/get_project_details_view_model/get_project_details_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/projects/update_project_view_model/update_project_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/projects/update_project_view_model/update_project_view_model_states.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/project_images_section.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/project_info_section.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/social_links_section.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/working_hours_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/components/confirmation_dialog.dart';
import '../../../../../../../core/services/image_picker_service.dart';
import '../../../../../../../core/services/image_upload_service.dart';
import '../../../../../../../core/services/notification_service.dart';
import '../manager/projects/delete_project_view_model/delete_project_view_model_states.dart';
import '../manager/projects/get_project_details_view_model/get_project_details_view_model_states.dart';
import 'action_buttons_section.dart';
import 'ad_settings_section.dart';
import 'gallery_section.dart';

class AdminProjectEditViewBody extends StatefulWidget {
  const AdminProjectEditViewBody({
    super.key,
    required this.approveText,
    required this.rejectText,
    required this.isEdit,
  });

  final String approveText;
  final String rejectText;
  final bool isEdit;

  @override
  State<AdminProjectEditViewBody> createState() =>
      _AdminProjectEditViewBodyState();
}

class _AdminProjectEditViewBodyState extends State<AdminProjectEditViewBody> {
  final titleController = TextEditingController(text: "عنوان المشروع");
  final locationController = TextEditingController(text: "دمشق");
  final descriptionController = TextEditingController(text: "وصف المشروع ...");
  final whatsappController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final websiteController = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final durationController = TextEditingController(text: "30");
  final mapLinkController = TextEditingController();
  final imagePicker = ImagePickerService();
  final imageUploader = ImageUploadService();

  bool isInitialized = false;

  String tier = "normal";
  bool isActive = false;

  List<String> galleryImages = [];
  List<String> additionalImages = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetProjectDetailsViewModel,
      GetProjectDetailsViewModelStates
    >(
      builder: (context, state) {
        if (state is GetProjectDetailsViewModelLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        }

        if (state is GetProjectDetailsViewModelSuccess) {
          if (!isInitialized) {
            titleController.text = state.project.title;
            locationController.text = state.project.location;
            descriptionController.text = state.project.description;
            whatsappController.text = state.project.phone;
            durationController.text = state.project.duration;
            tier = state.project.tier;
            isActive = state.project.isActive;
            galleryImages = List.from(state.project.images);
            fromController.text = state.project.workTimeFrom ?? "";
            toController.text = state.project.workTimeTo ?? "";
            facebookController.text = state.project.facebook ?? "";
            instagramController.text = state.project.instagram ?? "";
            websiteController.text = state.project.website ?? "";
            mapLinkController.text = state.project.mapLink ?? "";
            additionalImages = List.from(state.project.additionalImages);

            isInitialized = true;
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProjectImagesSection(
                        images: galleryImages,
                        onAddImage: () {},
                      ),
                      SizedBox(height: 20.h),

                      ProjectInfoSection(
                        titleController: titleController,
                        locationController: locationController,
                        descriptionController: descriptionController,
                        phoneController: whatsappController,
                      ),
                      SizedBox(height: 20.h),

                      WorkingHoursSection(
                        fromController: fromController,
                        toController: toController,
                      ),
                      SizedBox(height: 20.h),

                      SocialLinksSection(
                        facebookController: facebookController,
                        instagramController: instagramController,
                        websiteController: websiteController,
                        mapLinkController: mapLinkController,
                      ),

                      AdSettingsSection(
                        durationController: durationController,
                        tier: tier,
                        onTierChanged: (value) => setState(() => tier = value!),
                        isActive: isActive,
                        onActiveChanged: (value) =>
                            setState(() => isActive = value),
                      ),
                      SizedBox(height: 20.h),

                      GallerySection(
                        images: additionalImages,
                        onAddImage: () async {
                          final picked = await imagePicker.pickFromGallery();
                          if (picked.isEmpty) return;

                          final url = await imageUploader.uploadImage(
                            bytes: picked.bytes!,
                            bucket: "projects",
                            folder: "additional",
                          );

                          if (url != null) {
                            setState(() {
                              additionalImages.add(url);
                            });
                          }
                        },
                        onRemoveImage: (index) {
                          setState(() {
                            additionalImages.removeAt(index);
                          });
                        },
                      ),

                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),

              MultiBlocListener(
                listeners: [
                  /// 🔥 نجاح / فشل التحديث
                  BlocListener<UpdateProjectViewModel, UpdateProjectViewModelStates>(
                    listener: (context, updateState) {
                      if (updateState is UpdateProjectViewModelSuccess) {
                        showTemporaryMessage(
                          context,
                          "تم تحديث المشروع بنجاح",
                          MessageType.success,
                        );

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutesManager.home,
                              (_) => false,
                        );
                      }

                      if (updateState is UpdateProjectViewModelError) {
                        showTemporaryMessage(
                          context,
                          updateState.message,
                          MessageType.error,
                        );
                      }
                    },
                  ),

                  /// 🔥 نجاح / فشل حذف المشروع
                  BlocListener<DeleteProjectViewModel, DeleteProjectViewModelStates>(
                    listener: (context, deleteState) {
                      if (deleteState is DeleteProjectViewModelSuccess) {
                        showTemporaryMessage(
                          context,
                          "تم حذف المشروع بنجاح",
                          MessageType.success,
                        );

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutesManager.home,
                              (_) => false,
                        );
                      }

                      if (deleteState is DeleteProjectViewModelError) {
                        showTemporaryMessage(
                          context,
                          deleteState.message,
                          MessageType.error,
                        );
                      }
                    },
                  ),
                ],
                child: ActionButtonsSection(
                  approveText: widget.approveText,
                  rejectText: widget.rejectText,

                  onApprove: () {
                    showConfirmationDialog(
                      context: context,
                      title: widget.isEdit
                          ? "تأكيد التعديل"
                          : "تأكيد الموافقة",
                      message: widget.isEdit
                          ? "هل أنت متأكد أنك تريد تعديل هذا المشروع؟"
                          : "هل أنت متأكد أنك تريد الموافقة على هذا المشروع؟",
                      onConfirm: () {
                        print({
                          "id": state.project.id,
                          "categoryTitle": state.project.categoryTitle,
                          "logo": state.project.logo,
                          "userId": state.project.userId,
                          "displaySections": state.project.displaySections,
                        });

                        context.read<UpdateProjectViewModel>().updateProject(
                          ProjectEntity(
                            id: state.project.id,
                            title: titleController.text,
                            description: descriptionController.text,
                            categoryTitle: state.project.categoryTitle,
                            images: galleryImages,
                            logo: state.project.logo,
                            phone: whatsappController.text,
                            location: locationController.text,
                            isActive: true,
                            facebook: facebookController.text,
                            instagram: instagramController.text,
                            website: websiteController.text,
                            mapLink: mapLinkController.text,
                            whatsapp: whatsappController.text,
                            workTimeFrom: fromController.text,
                            workTimeTo: toController.text,
                            duration: durationController.text,
                            createdAt: state.project.createdAt,

                            status: widget.isEdit
                                ? state.project.status
                                : "approved",

                            additionalImages: additionalImages,
                            tier: tier,
                            viewCountOn: isActive,
                            views: state.project.views,
                            displaySections: state.project.displaySections,
                            userId: state.project.userId,

                          ),
                        );
                      },
                      onCancel: () {},
                    );
                  },

                  onReject: () {
                    showConfirmationDialog(
                      context: context,
                      title: widget.isEdit ? "تأكيد الحذف" : "تأكيد الرفض",
                      message: widget.isEdit
                          ? "هل أنت متأكد من حذف هذا المشروع؟"
                          : "هل أنت متأكد من رفض هذا المشروع؟",
                      onConfirm: () {
                        if (widget.isEdit) {
                          /// 🔥 حذف المشروع
                          context
                              .read<DeleteProjectViewModel>()
                              .deleteProject(state.project.id);
                        } else {
                          /// 🔥 رفض المشروع
                          context
                              .read<UpdateProjectViewModel>()
                              .updateProject(
                            ProjectEntity(
                              id: state.project.id,
                              title: titleController.text,
                              description: descriptionController.text,
                              categoryTitle: state.project.categoryTitle,
                              images: galleryImages,
                              logo: state.project.logo,
                              phone: whatsappController.text,
                              location: locationController.text,
                              isActive: false,
                              facebook: facebookController.text,
                              instagram: instagramController.text,
                              website: websiteController.text,
                              mapLink: mapLinkController.text,
                              whatsapp: whatsappController.text,
                              workTimeFrom: fromController.text,
                              workTimeTo: toController.text,
                              duration: durationController.text,
                              createdAt: state.project.createdAt,
                              status: "rejected",
                              additionalImages: additionalImages,
                              tier: tier,
                              viewCountOn: isActive,
                              views: state.project.views,
                              displaySections: state.project.displaySections,
                              userId: state.project.userId,
                            ),
                          );
                        }
                      },
                      onCancel: () {},
                    );
                  },
                ),
              ),


              SizedBox(height: 12.h),
            ],
          );
        }

        return const Text("حدث خطأ");
      },
    );
  }
}
