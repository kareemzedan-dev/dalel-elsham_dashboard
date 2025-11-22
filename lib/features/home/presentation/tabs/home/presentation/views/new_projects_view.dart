import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../core/di/di.dart';
import '../manager/projects/get_pending_projects_view_model/get_pending_projects_view_model.dart';
import '../widgets/new_projects_view_body.dart';

class NewProjectsView extends StatelessWidget {
  const NewProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "اداره المشاريع الجديده"),
      body: BlocProvider(
        create: (context) => getIt<GetPendingProjectsViewModel>()..getPendingProjects(),
        child: const NewProjectsViewBody(),
      ),
    );
  }
}
