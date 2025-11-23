import 'package:dlyl_alsham_dashboard/config/routes/routes_manager.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/project_display_section_view_model/delete_project_display_section_view_model/delete_project_display_section_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/project_display_section_view_model/remove_project_from_section/remove_project_from_section.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/project_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/assets_manager.dart';
import '../../domain/entities/project_entity.dart';
import '../manager/project_display_section_view_model/remove_project_from_section/remove_project_from_section_states.dart';
import '../manager/projects/get_projects_by_display_section_view_model/get_projects_by_display_section_view_model.dart';
class ProjectsList extends StatelessWidget {
  const ProjectsList({super.key, required this.projects, required this.sectionId});

  final List<ProjectEntity> projects;
  final String sectionId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoveProjectFromSectionViewModel, RemoveProjectFromSectionStates>(
      listener: (context, state) {
        if (state is RemoveProjectFromSectionSuccess) {

          /// 🟢 إعادة تحميل المشاريع داخل هذا القسم
          context.read<GetProjectsByDisplaySectionViewModel>()
              .getProjectsByDisplaySection(sectionId);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("✔ تم حذف المشروع من المجموعة"),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is RemoveProjectFromSectionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("❌ فشل الحذف: ${state.message}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },

      child: SizedBox(
        height: 260.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: ProjectItem(
                projectEntity: projects[index],
                onDelete: () {
                  context.read<RemoveProjectFromSectionViewModel>()
                      .removeProjectFromSection(
                    projects[index].id,
                    sectionId,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
