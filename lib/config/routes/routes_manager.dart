import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/views/banners_management_view.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

import '../../core/enums/request_type.dart';
import '../../features/home/presentation/tabs/dalel_elsham/presentation/views/dalel_elsham_tab_view.dart';
import '../../features/home/presentation/tabs/home/domain/entities/job_entity.dart';
import '../../features/home/presentation/tabs/home/presentation/views/Job_opportunities_view.dart';
import '../../features/home/presentation/tabs/home/presentation/views/Job_opportunities_view_management.dart';
import '../../features/home/presentation/tabs/home/presentation/views/Job_seekers_view.dart';
import '../../features/home/presentation/tabs/home/presentation/views/add_new_service_view.dart';
import '../../features/home/presentation/tabs/home/presentation/views/admin_job_request_details_view.dart';
import '../../features/home/presentation/tabs/home/presentation/views/admin_project_edit_view.dart';
import '../../features/home/presentation/tabs/home/presentation/views/categories_details_view.dart';
import '../../features/home/presentation/tabs/home/presentation/views/job_offer_form_view.dart';
import '../../features/home/presentation/tabs/home/presentation/views/job_request_form_view.dart';
import '../../features/home/presentation/tabs/home/presentation/views/new_projects_view.dart';
import '../../features/home/presentation/tabs/home/presentation/views/prayer_times_view.dart';
import '../../features/home/presentation/tabs/home/presentation/views/project_details_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

class RoutesManager {
  static const String splash = "/";
  static const String home = "home";
  static const String categoriesDetails = "categoriesDetails";
  static const String projectDetails = "projectDetails";
  static const String dalelElsham = "dalelElsham";
  static const String jobOpportunities = "jobOpportunities";
  static const String jobSeekers = "jobSeekers";
  static const String prayerTimes = "prayerTimes";

  static const String onboarding = "onboarding";
  static const String addNewService = "addNewService";
  static const String jobOfferForm = "jobOfferForm";
  static const String jobRequestForm = "jobRequestForm";
  static const String newProjects = "newProjects";
  static const String adminProjectEdit = "adminProjectEdit";
  static const String jobOpportunitiesManagement = "jobOpportunitiesManagement";
  static const String adminJobRequestDetails = "adminJobRequestDetails";
  static const String bannersManagement = "bannersManagement";

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case categoriesDetails:
        return MaterialPageRoute(builder: (_) => const CategoriesDetailsView());
      case projectDetails:
        return MaterialPageRoute(builder: (_) => const ProjectDetailsView());
      case dalelElsham:
        return MaterialPageRoute(builder: (_) => const DalelElshamTabView());
      case jobOpportunities:
        return MaterialPageRoute(builder: (_) => const JobOpportunitiesView());
      case jobSeekers:
        return MaterialPageRoute(builder: (_) => const JobSeekersView());
      case prayerTimes:
        return MaterialPageRoute(builder: (_) => const PrayerTimesView());

      case addNewService:
        return MaterialPageRoute(builder: (_) => const AddNewServiceView());
      case jobOfferForm:
        return MaterialPageRoute(builder: (_) => const JobOfferFormView());
      case jobRequestForm:
        return MaterialPageRoute(builder: (_) => const JobRequestFormView());
      case newProjects:
        return MaterialPageRoute(builder: (_) => const NewProjectsView());

      case adminProjectEdit:
        final arguments = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => AdminProjectEditView(
            projectId: arguments["projectId"]!,
            projectTitle: arguments["projectTitle"]!,
          ),
        );
      case jobOpportunitiesManagement:
        final arguments = settings.arguments as Map<String, String>;

        return MaterialPageRoute(
          builder: (_) => JobOpportunitiesViewManagement(
            title: arguments["title"],
            type: requestTypeFromString(arguments["type"]),
          ),
        );
      case adminJobRequestDetails:
        final arguments = settings.arguments as Map<String, dynamic>;

        final job = arguments["job"] as JobEntity;
        final title = arguments["title"] as String;

        return MaterialPageRoute(
          builder: (_) => AdminJobRequestDetailsView(
            job: job,
            title: title,
            type: arguments["type"] as RequestType,
          ),
        );
      case bannersManagement:
        return MaterialPageRoute(builder: (_) => const BannersManagementView());

      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}


