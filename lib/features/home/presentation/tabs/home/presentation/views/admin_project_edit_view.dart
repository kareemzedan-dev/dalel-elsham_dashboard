import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../core/di/di.dart';
import '../manager/projects/delete_project_view_model/delete_project_view_model.dart';
import '../manager/projects/get_project_details_view_model/get_project_details_view_model.dart';
import '../manager/projects/update_project_view_model/update_project_view_model.dart';
import '../widgets/admin_project_edit_view_body.dart';

class AdminProjectEditView extends StatelessWidget {
  const AdminProjectEditView({
    super.key,
    required this.projectId,
    required this.projectTitle,
    this.approveText,
    this.rejectText,
    this.isEdit = false,
  });

  final String projectId, projectTitle;
  final String? approveText;
  final String? rejectText;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: projectTitle),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                getIt<GetProjectDetailsViewModel>()
                  ..getProjectDetails(projectId),
          ),
          BlocProvider(create: (context) => getIt<UpdateProjectViewModel>()),
          BlocProvider(create: (context) => getIt<DeleteProjectViewModel>()),
        ],
        child: AdminProjectEditViewBody(
          approveText: approveText ?? "موافقة ونشر الإعلان",
          rejectText: rejectText ??"رفض / إلغاء الموافقة",
          isEdit: isEdit,
        ),
      ),
    );
  }
}
