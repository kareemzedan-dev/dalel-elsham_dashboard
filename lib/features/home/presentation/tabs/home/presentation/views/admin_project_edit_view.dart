import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../core/di/di.dart';
import '../manager/projects/get_project_details_view_model/get_project_details_view_model.dart';
import '../manager/projects/update_project_view_model/update_project_view_model.dart';
import '../widgets/admin_project_edit_view_body.dart';

class AdminProjectEditView extends StatelessWidget {
  const AdminProjectEditView({super.key, required this.projectId,required this.projectTitle});
  final String projectId,projectTitle;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        title: projectTitle,

      ),
      body: MultiBlocProvider(

          providers: [
            BlocProvider(
              create: (context) => getIt<GetProjectDetailsViewModel>()..getProjectDetails(projectId),
            ),
            BlocProvider(
              create: (context) => getIt<UpdateProjectViewModel>(),
            ),
          ],
          child: const AdminProjectEditViewBody()),
    );
}
}
