import 'package:dlyl_alsham_dashboard/config/routes/routes_manager.dart';
import 'package:dlyl_alsham_dashboard/core/components/confirmation_dialog.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/jobs/delete_job_view_model/delete_job_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/jobs/update_job_view_model/update_job_view_model_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../core/components/dismissible_error_card.dart';
import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/enums/request_type.dart';
import '../../domain/entities/job_entity.dart';
import '../manager/jobs/delete_job_view_model/delete_job_view_model_states.dart';
import '../manager/jobs/delete_opportunity_view_model/delete_opportunity_view_model.dart';
import '../manager/jobs/delete_opportunity_view_model/delete_opportunity_view_model_states.dart';
import '../manager/jobs/update_job_view_model/update_job_view_model.dart';
import '../manager/jobs/update_opportunity_view_model/update_job_view_model_states.dart';
import '../manager/jobs/update_opportunity_view_model/update_opportunity_view_model.dart';
import '../widgets/admin_job_request_details_view_body.dart';

class AdminJobRequestDetailsView extends StatefulWidget {
  const AdminJobRequestDetailsView({
    super.key,
    required this.job,
    required this.title,
    required this.type,
    required this.approveText,
    required this.rejectText,
  });

  final JobEntity job;
  final String title;
  final RequestType type;
  final String approveText;
  final String rejectText;

  @override
  State<AdminJobRequestDetailsView> createState() =>
      _AdminJobRequestDetailsViewState();
}

class _AdminJobRequestDetailsViewState
    extends State<AdminJobRequestDetailsView> {
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController phoneController;
  late TextEditingController descriptionController;
  late TextEditingController durationController;

  String selectedTier = "normal";

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.job.title);
    locationController = TextEditingController(text: widget.job.location);
    phoneController = TextEditingController(text: widget.job.phone);
    descriptionController = TextEditingController(text: widget.job.description);
    durationController = TextEditingController(text: widget.job.duration.toString());
    selectedTier = widget.job.type;
  }

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: widget.type == RequestType.job
          ? MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<UpdateJobViewModel>()),
          BlocProvider(create: (_) => getIt<DeleteJobViewModel>()),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<UpdateJobViewModel, UpdateJobViewModelStates>(
              listener: (context, state) {
                if (state is UpdateJobViewModelSuccess) {
                  Navigator.pushNamed(context, RoutesManager.home);
                  showTemporaryMessage(
                    context,
                    "تم تحديث حالة الطلب بنجاح",
                    MessageType.success,
                  );
                }
              },
            ),
            BlocListener<DeleteJobViewModel, DeleteJobViewModelStates>(
              listener: (context, state) {
                if (state is DeleteJobViewModelSuccess) {
                  Navigator.pushNamed(context, RoutesManager.home);
                  showTemporaryMessage(
                    context,
                    "تم حذف الطلب بنجاح",
                    MessageType.success,
                  );
                }
                if (state is DeleteJobViewModelError) {
                  showTemporaryMessage(
                    context,
                    state.message,
                    MessageType.error,
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<UpdateJobViewModel, UpdateJobViewModelStates>(
            builder: (context, state) {
              if (state is UpdateJobViewModelLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return AdminJobRequestDetailsViewBody(
                approveText: widget.approveText,
                rejectText: widget.rejectText,
                selectedTier: selectedTier,
                titleController: titleController,
                locationController: locationController,
                phoneController: phoneController,
                descriptionController: descriptionController,
                durationController: durationController,
                job: widget.job,
                title: "بيانات طلب العمل",
                onTierChanged: (value) {
                  setState(() {
                    selectedTier = value ?? "normal";
                  });
                },
                onApprove: () {
                  showConfirmationDialog(
                    title: widget.approveText,
                    message: "هل أنت متأكد من الموافقة على هذا الطلب؟",
                    context: context,
                    onConfirm: () {
                      context.read<UpdateJobViewModel>().updateJob(
                        JobEntity(
                          id: widget.job.id,
                          title: titleController.text,
                          description: descriptionController.text,
                          type: selectedTier,
                          phone: phoneController.text,
                          location: locationController.text,
                          imageUrl: widget.job.imageUrl,
                          isActive: true,
                          status: "approved",
                          duration: int.parse(durationController.text),
                          createdAt: widget.job.createdAt,
                          userId: widget.job.userId,
                        ),
                      );
                    },
                  );
                },
                onReject: () {
                  final isDelete = widget.rejectText.trim() == "حذف" ||
                      widget.rejectText.trim() == "حذف الطلب";

                  showConfirmationDialog(
                    title: widget.rejectText,
                    message: isDelete
                        ? "هل أنت متأكد أنك تريد حذف هذا الطلب نهائيًا؟"
                        : "هل أنت متأكد أنك تريد رفض هذا الطلب؟",
                    context: context,
                    onConfirm: () {
                      if (isDelete) {
                        context.read<DeleteJobViewModel>().deleteJob(widget.job.id);
                      } else {
                        context.read<UpdateJobViewModel>().updateJob(
                          JobEntity(
                            id: widget.job.id,
                            title: titleController.text,
                            description: descriptionController.text,
                            type: selectedTier,
                            phone: phoneController.text,
                            location: locationController.text,
                            imageUrl: widget.job.imageUrl,
                            isActive: false,
                            status: "rejected",
                            duration: int.parse(durationController.text),
                            createdAt: widget.job.createdAt,
                            userId: widget.job.userId,
                          ),
                        );
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      )
          : MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<UpdateOpportunityViewModel>()),
          BlocProvider(create: (_) => getIt<DeleteOpportunityViewModel>()),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<UpdateOpportunityViewModel, UpdateOpportunityViewModelStates>(
              listener: (context, state) {
                if (state is UpdateOpportunityViewModelSuccess) {
                  Navigator.pushNamed(context, RoutesManager.home);
                  showTemporaryMessage(
                    context,
                    "تم تحديث حالة الفرصة بنجاح",
                    MessageType.success,
                  );
                }
                if (state is UpdateOpportunityViewModelError) {
                  showTemporaryMessage(
                    context,
                    state.message,
                    MessageType.error,
                  );
                }
              },
            ),
            BlocListener<DeleteOpportunityViewModel, DeleteOpportunityViewModelStates>(
              listener: (context, state) {
                if (state is DeleteOpportunityViewModelSuccess) {
                  Navigator.pushNamed(context, RoutesManager.home);
                  showTemporaryMessage(
                    context,
                    "تم حذف الفرصة بنجاح",
                    MessageType.success,
                  );
                }
                if (state is DeleteOpportunityViewModelError) {
                  showTemporaryMessage(
                    context,
                    state.message,
                    MessageType.error,
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<UpdateOpportunityViewModel, UpdateOpportunityViewModelStates>(
            builder: (context, state) {
              if (state is UpdateOpportunityViewModelLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return AdminJobRequestDetailsViewBody(
                approveText: widget.approveText,
                rejectText: widget.rejectText,
                selectedTier: selectedTier,
                titleController: titleController,
                locationController: locationController,
                phoneController: phoneController,
                descriptionController: descriptionController,
                durationController: durationController,
                job: widget.job,
                title: "بيانات فرصة العمل",
                onTierChanged: (value) {
                  setState(() {
                    selectedTier = value ?? "normal";
                  });
                },
                onApprove: () {
                  showConfirmationDialog(
                    title: "تأكيد الموافقة",
                    message: "هل أنت متأكد من الموافقة على هذه الفرصة؟",
                    context: context,
                    onConfirm: () {
                      context.read<UpdateOpportunityViewModel>().updateOpportunity(
                        JobEntity(
                          id: widget.job.id,
                          title: titleController.text,
                          description: descriptionController.text,
                          type: selectedTier,
                          phone: phoneController.text,
                          location: locationController.text,
                          imageUrl: widget.job.imageUrl,
                          isActive: true,
                          status: "approved",
                          duration: int.parse(durationController.text),
                          createdAt: widget.job.createdAt,
                          userId: widget.job.userId,
                        ),
                      );
                    },
                  );
                },
                onReject: () {
                  final isDelete = widget.rejectText.trim() == "حذف" ||
                      widget.rejectText.trim() == "حذف الطلب";

                  showConfirmationDialog(
                    title: widget.rejectText,
                    message: isDelete
                        ? "هل أنت متأكد أنك تريد حذف هذه الفرصة نهائيًا؟"
                        : "هل أنت متأكد أنك تريد رفض هذه الفرصة؟",
                    context: context,
                    onConfirm: () {
                      if (isDelete) {
                        context.read<DeleteOpportunityViewModel>().deleteOpportunity(widget.job.id);
                      } else {
                        context.read<UpdateOpportunityViewModel>().updateOpportunity(
                          JobEntity(
                            id: widget.job.id,
                            title: titleController.text,
                            description: descriptionController.text,
                            type: selectedTier,
                            phone: phoneController.text,
                            location: locationController.text,
                            imageUrl: widget.job.imageUrl,
                            isActive: false,
                            status: "rejected",
                            duration: int.parse(durationController.text),
                            createdAt: widget.job.createdAt,
                            userId: widget.job.userId,
                          ),
                        );
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
