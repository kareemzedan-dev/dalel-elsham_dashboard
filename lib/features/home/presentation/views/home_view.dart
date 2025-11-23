import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/project_display_section_view_model/remove_project_from_section/remove_project_from_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/routes_manager.dart';
import '../../../../core/di/di.dart';
import '../tabs/dalel_elsham/presentation/manager/add_place_view_model/add_place_view_model.dart';
import '../tabs/dalel_elsham/presentation/manager/delete_place_view_model/delete_place_view_model.dart';
import '../tabs/dalel_elsham/presentation/manager/get_all_place_view_model/get_all_place_view_model.dart';
import '../tabs/dalel_elsham/presentation/manager/update_place_view_model/update_place_view_model.dart';
import '../tabs/dalel_elsham/presentation/views/dalel_elsham_tab_view.dart';
import '../tabs/home/presentation/manager/app_links/get_all_app_links_view_model/get_all_app_links_view_model.dart';
import '../tabs/home/presentation/manager/banners/get_banners_by_position_view_model/get_banners_by_position_view_model.dart';
import '../tabs/home/presentation/manager/categories/delete_category_view_model/delete_category_view_model.dart';
import '../tabs/home/presentation/manager/categories/get_all_categories_view_model/get_all_categories_view_model.dart';
import '../tabs/home/presentation/manager/project_display_section_view_model/delete_project_display_section_view_model/delete_project_display_section_view_model.dart';
import '../tabs/home/presentation/manager/project_display_section_view_model/get_all_project_display_sections_view_model/get_all_project_display_sections_view_model.dart';
import '../tabs/home/presentation/manager/project_display_section_view_model/update_project_display_section_view_model/update_project_display_section_view_model.dart';
import '../tabs/home/presentation/manager/projects/get_newest_projects_view_model/get_newest_projects_view_model.dart';
import '../tabs/home/presentation/manager/projects/get_projects_by_display_section_view_model/get_projects_by_display_section_view_model.dart';
import '../tabs/home/presentation/widgets/drawer_content.dart';
import '../tabs/home/presentation/widgets/custom_bottom_nav_bar.dart';
import '../tabs/home/presentation/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;



  late final List<Widget> _pages = [
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<GetBannersByPositionViewModel>()..getBannersByPosition("home"),
        ),

        BlocProvider(
          create: (_) => getIt<GetAllProjectDisplaySectionsViewModel>()..getAllProjectDisplaySections(),
        ),
        BlocProvider(
          create: (_) => getIt<GetNewestProjectsViewModel>()..getNewestProjects(),
        ),


        BlocProvider(
          create: (_) => getIt<GetProjectsByDisplaySectionViewModel>(),
        ),
        BlocProvider(
          create: (_) => getIt<DeleteCategoryViewModel>(),
        ),
        BlocProvider(
          create: (_) => getIt<UpdateProjectDisplaySectionViewModel>(),
        ),
        BlocProvider(
          create: (_) => getIt<DeleteProjectDisplaySectionViewModel>(),
        ),
        BlocProvider(
          create: (_) => getIt<RemoveProjectFromSectionViewModel>(),
        ),



      ],
      child: const HomeViewBody(),
    ),

    MultiBlocProvider(

        providers: [
          BlocProvider(create: (context) => getIt<DeletePlaceViewModel>()),
          BlocProvider(create: (context) => getIt<UpdatePlaceViewModel>()),
          BlocProvider(create: (context) => getIt<AddPlaceViewModel>()),
          BlocProvider(create: (context) => getIt<GetAllPlaceViewModel>()..getAllPlaces()),
        ],
        child:   DalelElshamTabView()),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BlocProvider(
        create: (_) => getIt<GetAllAppLinksViewModel>()..getAllAppLinks(),
        child: Drawer(child: DrawerContent()),
      ),

      extendBody: true,

      body: IndexedStack(index: currentIndex, children: _pages),



      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onItemTapped: (index) {
          setState(() => currentIndex = index);
        },
      ),
    );
  }
}
