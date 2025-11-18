import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/data/data_sources/remote/projects/get_all_projects_remote_data_source/get_all_projects_remote_data_source.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/projects/get_all_projects_view_model/get_all_projects_view_model_states.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/pending_project_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/routes/routes_manager.dart';
import '../manager/projects/get_all_projects_view_model/get_all_projects_view_model.dart';

class PendingProjectsList extends StatelessWidget {
  const PendingProjectsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllProjectsViewModel, GetAllProjectsViewModelStates>(
      builder: (context, state) {
        if (state is GetAllProjectsViewModelLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetAllProjectsViewModelSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.projects.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical:  8.0),
                child: PendingProjectCard(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesManager.adminProjectEdit,arguments: {
                      "projectId": state.projects[index].id,
                      "projectTitle": state.projects[index].title,
                    });
                  },
                  project: state.projects[index],
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
