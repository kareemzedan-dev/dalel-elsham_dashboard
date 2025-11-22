import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/projects/get_all_projects_view_model/get_all_projects_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/projects/get_all_projects_view_model/get_all_projects_view_model_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/project_entity.dart';
import '../manager/project_display_section_view_model/add_project_to_section_view_model/add_project_to_section_view_model.dart';
import '../manager/project_display_section_view_model/add_project_to_section_view_model/add_project_to_section_view_model_states.dart';

class AddProjectToSectionSheet extends StatefulWidget {
  final String sectionId;

  const AddProjectToSectionSheet({super.key, required this.sectionId});

  @override
  State<AddProjectToSectionSheet> createState() =>
      _AddProjectToSectionSheetState();
}

class _AddProjectToSectionSheetState extends State<AddProjectToSectionSheet> {
  ProjectEntity? selectedProject;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProjectToSectionViewModel,
        AddProjectToSectionViewModelStates>(
      listener: (context, state) {
        if (state is AddProjectToSectionViewModelSuccess) {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("تم إضافة المشروع إلى القسم بنجاح"),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is AddProjectToSectionViewModelError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },

      child: Container(
        padding: EdgeInsets.all(16.w),
        height: MediaQuery.of(context).size.height * 0.8,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Title ---
            Text(
              "إضافة مشروع إلى ${widget.sectionId}",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16.h),

            /// --- Project List ---
            Expanded(
              child: BlocBuilder<GetAllProjectsViewModel,
                  GetAllProjectsViewModelStates>(
                builder: (context, state) {
                  if (state is GetAllProjectsViewModelLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is GetAllProjectsViewModelSuccess) {
                    final projects = state.projects;

                    if (projects.isEmpty) {
                      return const Center(
                        child: Text("لا توجد مشاريع متاحة"),
                      );
                    }

                    return ListView.builder(
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        final project = projects[index];
                        final isSelected = selectedProject?.id == project.id;

                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedProject = project);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 6.h),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: isSelected
                                  ? Colors.blue.withOpacity(0.2)
                                  : Colors.grey.shade200,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.grey.shade400,
                              ),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: project.logo.isNotEmpty
                                      ? Image.network(
                                    project.logo,
                                    width: 60.w,
                                    height: 60.h,
                                    fit: BoxFit.cover,
                                  )
                                      : const Icon(Icons.image),
                                ),
                                SizedBox(width: 12.w),

                                /// Title
                                Expanded(
                                  child: Text(
                                    project.title,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const Center(
                    child: Text("خطأ في تحميل المشاريع"),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),

            /// --- Add Button ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedProject == null
                    ? null
                    : () {
                  context
                      .read<AddProjectToSectionViewModel>()
                      .addProjectToSection(
                    projectId: selectedProject!.id,
                    sectionId: widget.sectionId,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  backgroundColor: selectedProject != null
                      ? Colors.blue
                      : Colors.grey.shade400,
                ),
                child: BlocBuilder<AddProjectToSectionViewModel,
                    AddProjectToSectionViewModelStates>(
                  builder: (context, state) {
                    if (state is AddProjectToSectionViewModelLoading) {
                      return const CircularProgressIndicator(
                          color: Colors.white);
                    }
                    return Text(
                      "إضافة",
                      style:
                      TextStyle(fontSize: 16.sp, color: Colors.white),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
