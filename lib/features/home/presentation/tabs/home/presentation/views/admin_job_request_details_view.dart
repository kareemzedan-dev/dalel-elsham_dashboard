import 'package:dlyl_alsham_dashboard/config/routes/routes_manager.dart';
import 'package:dlyl_alsham_dashboard/core/components/confirmation_dialog.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/jobs/update_job_view_model/update_job_view_model_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../core/components/dismissible_error_card.dart';
import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/enums/request_type.dart';
import '../../domain/entities/job_entity.dart';
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
  });

  final JobEntity job;
  final String title;
  final RequestType type;

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
    durationController = TextEditingController(
      text: widget.job.duration.toString(),
    );
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
          ? BlocProvider(
              create: (context) => getIt<UpdateJobViewModel>(),
              child: BlocConsumer<UpdateJobViewModel, UpdateJobViewModelStates>(
                listener: (context, state) {
                  if (state is UpdateOpportunityViewModelSuccess) {
                    Navigator.pushNamed(context, RoutesManager.home);
                    showTemporaryMessage(
                      context,
                      "تم تحديث حالة الطلب بنجاح",
                      MessageType.success,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UpdateJobViewModelLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return AdminJobRequestDetailsViewBody(
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
                        title: "تأكيد الموافقة",

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
                            ),
                          );
                        },
                        message: "هل انت متاكد من الموافقة على هذا الطلب",
                        context: context,
                      );
                    },
                    onReject: () {
                      showConfirmationDialog(
                        title: "تأكيد الرفض",

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
                              isActive: false,
                              status: "rejected",
                              duration: int.parse(durationController.text),
                              createdAt: widget.job.createdAt,
                            ),
                          );
                        },
                        message: "هل انت متاكد من الرفض على هذا الطلب",
                        context: context,
                      );
                    },
                  );
                },
              ),
            )
          : BlocProvider(
              create: (context) => getIt<UpdateOpportunityViewModel>(),
              child:
                  BlocConsumer<
                    UpdateOpportunityViewModel,
                    UpdateOpportunityViewModelStates
                  >(
                    listener: (context, state) {
                      if (state is UpdateOpportunityViewModelSuccess) {
                        Navigator.pushNamed(context, RoutesManager.home);
                        showTemporaryMessage(
                          context,
                          "تم تحديث حالة الطلب بنجاح",
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
                    builder: (context, state) {
                      if (state is UpdateOpportunityViewModelLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return AdminJobRequestDetailsViewBody(
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

                            onConfirm: () {
                              context
                                  .read<UpdateOpportunityViewModel>()
                                  .updateOpportunity(
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
                                      duration: int.parse(
                                        durationController.text,
                                      ),
                                      createdAt: widget.job.createdAt,
                                    ),
                                  );
                            },
                            message: "هل انت متاكد من الموافقة على هذا الطلب",
                            context: context,
                          );
                        },
                        onReject: () {
                          showConfirmationDialog(
                            title: "تأكيد الرفض",

                            onConfirm: () {
                              context
                                  .read<UpdateOpportunityViewModel>()
                                  .updateOpportunity(
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
                                      duration: int.parse(
                                        durationController.text,
                                      ),
                                      createdAt: widget.job.createdAt,
                                    ),
                                  );
                            },
                            message: "هل انت متاكد من الرفض على هذا الطلب",
                            context: context,
                          );
                        },
                      );
                    },
                  ),
            ),
    );
  }
}
