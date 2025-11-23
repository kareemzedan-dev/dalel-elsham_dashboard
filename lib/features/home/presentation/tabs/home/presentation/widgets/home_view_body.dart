import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/project_display_section_view_model/update_project_display_section_view_model/update_project_display_section_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/skeletons/banner_section_skeleton.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/skeletons/category_item_list_skeleton.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/skeletons/display_sections_skeleton.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/skeletons/project_list_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/utils/colors_manager.dart';
import '../../domain/entities/project_display_section_entity.dart';
import '../manager/banners/get_banners_by_position_view_model/get_banners_by_position_view_model.dart';
import '../manager/banners/get_banners_by_position_view_model/get_banners_by_position_view_model_states.dart';
import '../manager/categories/get_all_categories_view_model/get_all_categories_view_model.dart';
import '../manager/categories/get_all_categories_view_model/get_all_categories_view_model_states.dart';

import '../manager/project_display_section_view_model/add_project_display_section_view_model/add_project_display_section_view_model.dart';
import '../manager/project_display_section_view_model/add_project_to_section_view_model/add_project_to_section_view_model.dart';
import '../manager/project_display_section_view_model/delete_project_display_section_view_model/delete_project_display_section_view_model.dart';
import '../manager/project_display_section_view_model/delete_project_display_section_view_model/delete_project_display_section_view_model_states.dart';
import '../manager/project_display_section_view_model/get_all_project_display_sections_view_model/get_all_project_display_sections_view_model.dart';
import '../manager/project_display_section_view_model/get_all_project_display_sections_view_model/get_all_project_display_sections_view_model_states.dart';
import '../manager/project_display_section_view_model/update_project_display_section_view_model/update_project_display_section_view_model_states.dart';
import '../manager/projects/get_all_projects_view_model/get_all_projects_view_model.dart';
import '../manager/projects/get_newest_projects_view_model/get_newest_projects_view_model.dart';
import '../manager/projects/get_newest_projects_view_model/get_newest_projects_view_model_states.dart';
import '../manager/projects/get_projects_by_display_section_view_model/get_projects_by_display_section_view_model.dart';
import '../manager/projects/get_projects_by_display_section_view_model/get_projects_by_display_section_view_model_states.dart';
import '../views/search_for_projects_view.dart';
import 'add_project_to_section_sheet.dart';
import 'add_section_sheet.dart';
import 'banner_section.dart';
import 'categories_section.dart';
import 'top_bar_section.dart';
import 'services_section.dart';
import 'section_widget.dart';
import 'projects_list.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  /// REFRESH FUNCTION
  Future<void> _onRefresh(BuildContext context) async {
    context.read<GetBannersByPositionViewModel>().getBannersByPosition("home");
    context.read<GetAllCategoriesViewModel>().getAllCategories();
    context
        .read<GetAllProjectDisplaySectionsViewModel>()
        .getAllProjectDisplaySections();
    context.read<GetNewestProjectsViewModel>().getNewestProjects();

    /// إعادة تحميل مشاريع كل سكشن
    final displayState = context
        .read<GetAllProjectDisplaySectionsViewModel>()
        .state;
    if (displayState is GetAllProjectDisplaySectionsViewModelSuccess) {
      final sections = displayState.projectDisplaySections;
    }

    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      color: ColorsManager.primaryColor,

      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// TOP BAR
                TopBarSection(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 350),
                        pageBuilder: (_, animation, __) {
                          return FadeTransition(
                            opacity: animation,
                            child: const SearchForProjectsView(),
                          );
                        },
                      ),
                    );
                  },
                ),

                SizedBox(height: 30.h),

                /// BANNERS
                _buildHomeBanners(),

                SizedBox(height: 30.h),

                /// DISPLAY SECTIONS
                BlocBuilder<
                    GetAllProjectDisplaySectionsViewModel,
                    GetAllProjectDisplaySectionsViewModelStates
                >(
                  builder: (context, state) {
                    if (state is GetAllProjectDisplaySectionsViewModelLoading) {
                      return const DisplaySectionsSkeleton();
                    }

                    if (state is GetAllProjectDisplaySectionsViewModelSuccess) {
                      final sections = state.projectDisplaySections;

                      /// Fetch projects once
                      final projectBloc = context
                          .read<GetProjectsByDisplaySectionViewModel>();
                      for (var sec in sections) {
                        projectBloc.getProjectsByDisplaySection(sec.id);
                      }

                      if (sections.isEmpty) return const SizedBox.shrink();

                      final first = sections.first;
                      final others = sections.skip(1).toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCategories(),
                          SizedBox(height: 30.h),

                          _buildProjectSection(first.id, first.title, context),
                          SizedBox(height: 30.h),

                          const ServicesSection(),
                          SizedBox(height: 30.h),

                          _buildNewestProjects(),
                          SizedBox(height: 30.h),

                          ...others.map(
                                (sec) =>
                                Padding(
                                  padding: EdgeInsets.only(bottom: 30.h),
                                  child: _buildProjectSection(
                                    sec.id,
                                    sec.title,
                                    context,
                                  ),
                                ),
                          ),

                          /// زر إضافة قسم جديد
                          SizedBox(height: 20.h),

                          Center(
                            child: GestureDetector(
                              onTap: () => _openAddSectionBottomSheet(context),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorsManager.primaryColor,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 22.sp,
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      "إضافة قسم جديد",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return const DisplaySectionsSkeleton();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BANNERS
  // ============================================================

  Widget _buildHomeBanners() {
    return BlocBuilder<
        GetBannersByPositionViewModel,
        GetBannersByPositionViewModelStates
    >(
      builder: (context, state) {
        if (state is GetBannersByPositionViewModelStatesLoading) {
          return const BannerSectionSkeleton();
        }
        if (state is GetBannersByPositionViewModelStatesSuccess) {
          return BannerSection(images: state.banners);
        }
        return const BannerSectionSkeleton();
      },
    );
  }

  // ============================================================
  // CATEGORIES
  // ============================================================

  Widget _buildCategories() {
    return BlocBuilder<
        GetAllCategoriesViewModel,
        GetAllCategoriesViewModelStates
    >(
      builder: (context, state) {
        if (state is GetAllCategoriesViewModelLoading) {
          return const CategoryItemListSkeleton();
        }
        if (state is GetAllCategoriesViewModelSuccess) {
          return CategoriesSection(
            categoriesList: state.categories,
            isAdmin: true,
          );
        }
        return const CategoryItemListSkeleton();
      },
    );
  }

  // ============================================================
  // NEWEST PROJECTS
  // ============================================================

  Widget _buildNewestProjects() {
    return SectionWidget(
      title: "نورونا جديد",
      child:
      BlocBuilder<
          GetNewestProjectsViewModel,
          GetNewestProjectsViewModelStates
      >(
        builder: (context, state) {
          if (state is GetNewestProjectsViewModelLoading) {
            return const ProjectListSkeleton();
          }
          if (state is GetNewestProjectsViewModelSuccess) {
            return ProjectsList(projects: state.projects,sectionId: "");
          }
          return const ProjectListSkeleton();
        },
      ),
    );
  }
// ============================================================
// PROJECT SECTION
// ============================================================
  Widget _buildProjectSection(
      String id,
      String title,
      BuildContext parentContext,
      ) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<GetProjectsByDisplaySectionViewModel>()
            ..getProjectsByDisplaySection(id),
        ),
        BlocProvider(
          create: (_) => getIt<UpdateProjectDisplaySectionViewModel>(),
        ),
        BlocProvider(
          create: (_) => getIt<DeleteProjectDisplaySectionViewModel>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          /// ========= LISTENER تحديث القسم =========
          BlocListener<UpdateProjectDisplaySectionViewModel,
              UpdateProjectDisplaySectionViewModelStates>(
            listener: (context, state) {
              if (state is UpdateProjectDisplaySectionViewModelSuccess) {
                parentContext
                    .read<GetAllProjectDisplaySectionsViewModel>()
                    .getAllProjectDisplaySections();

                ScaffoldMessenger.of(parentContext).showSnackBar(
                  const SnackBar(
                    content: Text("✔ تم تحديث القسم بنجاح"),
                    backgroundColor: Colors.green,
                  ),
                );
              }

              if (state is UpdateProjectDisplaySectionViewModelError) {
                ScaffoldMessenger.of(parentContext).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),

          /// ========= LISTENER حذف القسم =========
          BlocListener<DeleteProjectDisplaySectionViewModel,
              DeleteProjectDisplaySectionViewModelStates>(
            listener: (context, state) {
              if (state is DeleteProjectDisplaySectionViewModelSuccess) {
                parentContext
                    .read<GetAllProjectDisplaySectionsViewModel>()
                    .getAllProjectDisplaySections();

                ScaffoldMessenger.of(parentContext).showSnackBar(
                  const SnackBar(
                    content: Text("✔ تم حذف القسم بنجاح"),
                    backgroundColor: Colors.red,
                  ),
                );
              }

              if (state is DeleteProjectDisplaySectionViewModelError) {
                ScaffoldMessenger.of(parentContext).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: SectionWidget(
          title: title,

          /// ========== حذف القسم ==========
          onDeleteTitle: (context) {
            _showDeleteDialog(context, parentContext, id);
          },
          onEditOrder: (context, newOrder) {
            final sectionsState = parentContext
                .read<GetAllProjectDisplaySectionsViewModel>()
                .state as GetAllProjectDisplaySectionsViewModelSuccess;

            final originalSection = sectionsState.projectDisplaySections
                .firstWhere((e) => e.id == id);

            context
                .read<UpdateProjectDisplaySectionViewModel>()
                .updateProjectDisplaySection(
              ProjectDisplaySectionEntity(
                id: originalSection.id,
                title: originalSection.title,
                order: newOrder,
                createdAt: originalSection.createdAt,
                isActive: originalSection.isActive,
              ),
            );
          },


          /// ========== تعديل العنوان ==========
          onEditTitle: (context, newTitle) {
            final sectionsState = parentContext
                .read<GetAllProjectDisplaySectionsViewModel>()
                .state as GetAllProjectDisplaySectionsViewModelSuccess;

            final originalSection = sectionsState.projectDisplaySections
                .firstWhere((e) => e.id == id);

            context
                .read<UpdateProjectDisplaySectionViewModel>()
                .updateProjectDisplaySection(
              ProjectDisplaySectionEntity(
                id: originalSection.id,
                title: newTitle,
                order: originalSection.order,
                createdAt: originalSection.createdAt,
                isActive: originalSection.isActive,
              ),
            );
          },

          onTap: () => _openAddProjectBottomSheet(parentContext, id),

          child: BlocBuilder<GetProjectsByDisplaySectionViewModel,
              GetProjectsByDisplaySectionViewModelStates>(
            builder: (context, state) {
              if (state is GetProjectsByDisplaySectionViewModelStatesLoading) {
                return const ProjectListSkeleton();
              }

              if (state is GetProjectsByDisplaySectionViewModelStatesSuccess) {
                if (state.projects.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Center(
                      child: Text(
                        "لا يوجد مشاريع في هذا القسم حالياً",
                        style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                      ),
                    ),
                  );
                }
                return ProjectsList(projects: state.projects,sectionId: id);
              }

              return const ProjectListSkeleton();
            },
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext sectionContext,
      BuildContext parentContext,
      String sectionId,
      ) {
    showDialog(
      context: sectionContext,
      builder: (_) {
        return AlertDialog(
          title: const Text("حذف القسم"),
          content: const Text("هل أنت متأكد أنك تريد حذف هذا القسم؟"),
          actions: [
            TextButton(
              child: const Text("إلغاء"),
              onPressed: () => Navigator.pop(sectionContext),
            ),
            TextButton(
              child: const Text("حذف", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.pop(sectionContext);

                /// هنا أخيرًا هنفذ من context اللي فيه ال BlocProvider
                sectionContext
                    .read<DeleteProjectDisplaySectionViewModel>()
                    .deleteProjectDisplaySection(sectionId);

                /// اعمل refresh للصفحة كلها
                parentContext
                    .read<GetAllProjectDisplaySectionsViewModel>()
                    .getAllProjectDisplaySections();
              },
            ),
          ],
        );
      },
    );
  }





  void _openAddProjectBottomSheet(BuildContext context, String sectionId, ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
              getIt<GetAllProjectsViewModel>()
                ..getAllProjects(),
            ),
            BlocProvider(create: (_) => getIt<AddProjectToSectionViewModel>()),
          ],
          child: AddProjectToSectionSheet(sectionId: sectionId),
        );
      },
    );
  }

  void _openAddSectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return BlocProvider(
          create: (_) => getIt<AddProjectDisplaySectionViewModel>(),
          child: const AddSectionSheet(),
        );
      },
    );
  }
}
