// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/home/presentation/tabs/home/data/data_sources/remote/banner_remote_data_source/banners_remote_data_source.dart'
    as _i1046;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/category_remote_data_source/category_remote_data_source.dart'
    as _i786;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/jobs/add_job_remote_data_source/add_job_remote_data_source.dart'
    as _i425;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/jobs/add_opportunity_remote_data_source/add_opportunity_remote_data_source.dart'
    as _i585;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/jobs/delete_job_remote_data_source/delete_job_remote_data_source.dart'
    as _i107;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/jobs/get_all_jobs_remote_data_source/get_all_jobs_remote_data_source.dart'
    as _i847;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/jobs/get_all_opportunities_remote_data_source/get_all_opportunities_remote_data_source.dart'
    as _i563;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/jobs/get_job_by_id_remote_data_source/get_job_by_id_remote_data_source.dart'
    as _i104;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/projects/add_project_remote_data_source/add_project_remote_data_source.dart'
    as _i190;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/projects/delete_project_remote_data_source/delete_project_remote_data_source.dart'
    as _i694;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/projects/get_all_projects_remote_data_source/get_all_projects_remote_data_source.dart'
    as _i804;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/projects/get_project_details_remote_data_source/get_project_details_remote_data_source.dart'
    as _i131;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/projects/get_projects_by_category_remote_data_source/get_projects_by_category_remote_data_source.dart'
    as _i168;
import '../../features/home/presentation/tabs/home/data/data_sources/remote/projects/update_project_remote_data_source/update_project_remote_data_source.dart'
    as _i440;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/banner_remote_data_source_impl/banners_remote_data_source_impl.dart'
    as _i576;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/category_remote_data_source_impl/category_remote_data_source_impl.dart'
    as _i924;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/jobs/add_job_remote_data_source_impl/add_job_remote_data_source_impl.dart'
    as _i598;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/jobs/add_opportunity_remote_data_source_impl/add_opportunity_remote_data_source_impl.dart'
    as _i939;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/jobs/delete_job_remote_data_source_impl/delete_job_remote_data_source_impl.dart'
    as _i370;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/jobs/get_all_jobs_remote_data_source_impl/get_all_jobs_remote_data_source_impl.dart'
    as _i969;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/jobs/get_all_opportunities_remote_data_source_impl/get_all_opportunities_remote_data_source_impl.dart'
    as _i501;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/jobs/get_job_by_id_remote_data_source_impl/get_job_by_id_remote_data_source_impl.dart'
    as _i12;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/projects/add_project_remote_data_source_impl/add_project_remote_data_source_impl.dart'
    as _i1047;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/projects/delete_project_remote_data_source_impl/delete_project_remote_data_source_impl.dart'
    as _i487;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/projects/get_all_projects_remote_data_source_impl/get_all_projects_remote_data_source_impl.dart'
    as _i113;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/projects/get_project_details_remote_data_source_impl/get_project_details_remote_data_source_impl.dart'
    as _i379;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/projects/get_projects_by_category_remote_data_source_impl/get_projects_by_category_remote_data_source_impl.dart'
    as _i570;
import '../../features/home/presentation/tabs/home/data/data_sources_impl/remote/projects/update_project_remote_data_source_impl/update_project_remote_data_source_impl.dart'
    as _i394;
import '../../features/home/presentation/tabs/home/data/repos_impl/banners_repos_impl/banners_repos_impl.dart'
    as _i203;
import '../../features/home/presentation/tabs/home/data/repos_impl/category_repos_impl/category_repos_impl.dart'
    as _i672;
import '../../features/home/presentation/tabs/home/data/repos_impl/job/add_job_repo_impl/add_job_repo_impl.dart'
    as _i971;
import '../../features/home/presentation/tabs/home/data/repos_impl/job/add_opportunity_repo_impl/add_opportunity_repo_impl.dart'
    as _i658;
import '../../features/home/presentation/tabs/home/data/repos_impl/job/delete_job_repo_impl/delete_job_repo_impl.dart'
    as _i664;
import '../../features/home/presentation/tabs/home/data/repos_impl/job/get_all_jobs_repo_impl/get_all_jobs_repo_impl.dart'
    as _i394;
import '../../features/home/presentation/tabs/home/data/repos_impl/job/get_all_opportunities_repo_impl/get_all_opportunities_repo_impl.dart'
    as _i134;
import '../../features/home/presentation/tabs/home/data/repos_impl/job/get_job_by_id_repo_impl/get_job_by_id_repo_impl.dart'
    as _i93;
import '../../features/home/presentation/tabs/home/data/repos_impl/projects/add_project_repository_impl/add_project_repository_impl.dart'
    as _i63;
import '../../features/home/presentation/tabs/home/data/repos_impl/projects/delete_project_repository_impl/delete_project_repository_impl.dart'
    as _i687;
import '../../features/home/presentation/tabs/home/data/repos_impl/projects/get_all_projects_repository_impl/get_all_projects_repository_impl.dart'
    as _i528;
import '../../features/home/presentation/tabs/home/data/repos_impl/projects/get_project_details_repository_impl/get_project_details_repository_impl.dart'
    as _i80;
import '../../features/home/presentation/tabs/home/data/repos_impl/projects/get_projects_by_category_repository_impl/get_projects_by_category_repository_impl.dart'
    as _i61;
import '../../features/home/presentation/tabs/home/data/repos_impl/projects/update_project_repository_impl/update_project_repository_impl.dart'
    as _i1018;
import '../../features/home/presentation/tabs/home/domain/repos/banner_repository/banner_repository.dart'
    as _i572;
import '../../features/home/presentation/tabs/home/domain/repos/category_repos/category_repos.dart'
    as _i1066;
import '../../features/home/presentation/tabs/home/domain/repos/job/add_job_repo/add_job_repo.dart'
    as _i569;
import '../../features/home/presentation/tabs/home/domain/repos/job/add_opportunity_repo/add_opportunity_repo.dart'
    as _i495;
import '../../features/home/presentation/tabs/home/domain/repos/job/delete_job_repo/delete_job_repo.dart'
    as _i686;
import '../../features/home/presentation/tabs/home/domain/repos/job/get_all_jobs_repo/get_all_jobs_repo.dart'
    as _i903;
import '../../features/home/presentation/tabs/home/domain/repos/job/get_all_opportunities_repo/get_all_opportunities_repo.dart'
    as _i272;
import '../../features/home/presentation/tabs/home/domain/repos/job/get_job_by_id_repo/get_job_by_id_repo.dart'
    as _i108;
import '../../features/home/presentation/tabs/home/domain/repos/projects/add_project_repository/add_project_repository.dart'
    as _i45;
import '../../features/home/presentation/tabs/home/domain/repos/projects/delete_project_repository/delete_project_repository.dart'
    as _i822;
import '../../features/home/presentation/tabs/home/domain/repos/projects/get_all_projects_repository/get_all_projects_repository.dart'
    as _i925;
import '../../features/home/presentation/tabs/home/domain/repos/projects/get_project_details_repository/get_project_details_repository.dart'
    as _i184;
import '../../features/home/presentation/tabs/home/domain/repos/projects/get_projects_by_category_repository/get_projects_by_category_repository.dart'
    as _i250;
import '../../features/home/presentation/tabs/home/domain/repos/projects/update_project_repository/update_project_repository.dart'
    as _i943;
import '../../features/home/presentation/tabs/home/domain/use_cases/banner_use_case/banner_use_case.dart'
    as _i369;
import '../../features/home/presentation/tabs/home/domain/use_cases/category_use_case/category_use_case.dart'
    as _i886;
import '../../features/home/presentation/tabs/home/domain/use_cases/jobs_use_case/add_job_usecase/add_job_usecase.dart'
    as _i1047;
import '../../features/home/presentation/tabs/home/domain/use_cases/jobs_use_case/add_opportunity_usecase/add_opportunity_usecase.dart'
    as _i203;
import '../../features/home/presentation/tabs/home/domain/use_cases/jobs_use_case/delete_job_usecase/delete_job_usecase.dart'
    as _i111;
import '../../features/home/presentation/tabs/home/domain/use_cases/jobs_use_case/get_all_jobs_usecase/get_all_jobs_usecase.dart'
    as _i772;
import '../../features/home/presentation/tabs/home/domain/use_cases/jobs_use_case/get_all_opportunities_usecase/get_all_opportunities_usecase.dart'
    as _i365;
import '../../features/home/presentation/tabs/home/domain/use_cases/jobs_use_case/get_job_by_id_usecase/get_job_by_id_usecase.dart'
    as _i117;
import '../../features/home/presentation/tabs/home/domain/use_cases/projects/add_project_usecase/add_project_usecase.dart'
    as _i180;
import '../../features/home/presentation/tabs/home/domain/use_cases/projects/delete_project_usecase/delete_project_usecase.dart'
    as _i329;
import '../../features/home/presentation/tabs/home/domain/use_cases/projects/get_all_projects_usecase/get_all_projects_usecase.dart'
    as _i508;
import '../../features/home/presentation/tabs/home/domain/use_cases/projects/get_project_details_usecase/get_project_details_usecase.dart'
    as _i966;
import '../../features/home/presentation/tabs/home/domain/use_cases/projects/get_projects_by_category_usecase/get_projects_by_category_usecase.dart'
    as _i654;
import '../../features/home/presentation/tabs/home/domain/use_cases/projects/update_project_usecase/update_project_usecase.dart'
    as _i645;
import '../../features/home/presentation/tabs/home/presentation/manager/banners/get_banners_by_position_view_model/get_banners_by_position_view_model.dart'
    as _i76;
import '../../features/home/presentation/tabs/home/presentation/manager/categories/get_all_categories_view_model/get_all_categories_view_model.dart'
    as _i623;
import '../../features/home/presentation/tabs/home/presentation/manager/jobs/add_job_view_model/add_job_view_model.dart'
    as _i640;
import '../../features/home/presentation/tabs/home/presentation/manager/jobs/add_opportunity_view_model/add_opportunity_view_model.dart'
    as _i1036;
import '../../features/home/presentation/tabs/home/presentation/manager/jobs/get_all_jobs_view_model/get_all_jobs_view_model.dart'
    as _i29;
import '../../features/home/presentation/tabs/home/presentation/manager/jobs/get_all_opportunities_view_model/get_all_opportunities_view_model.dart'
    as _i1068;
import '../../features/home/presentation/tabs/home/presentation/manager/projects/add_project_view_model/add_project_view_model.dart'
    as _i61;
import '../../features/home/presentation/tabs/home/presentation/manager/projects/delete_project_view_model/delete_project_view_model.dart'
    as _i943;
import '../../features/home/presentation/tabs/home/presentation/manager/projects/get_all_projects_view_model/get_all_projects_view_model.dart'
    as _i907;
import '../../features/home/presentation/tabs/home/presentation/manager/projects/get_project_details_view_model/get_project_details_view_model.dart'
    as _i616;
import '../../features/home/presentation/tabs/home/presentation/manager/projects/get_projects_by_category_view_model/get_projects_by_category_view_model.dart'
    as _i696;
import '../../features/home/presentation/tabs/home/presentation/manager/projects/update_project_view_model/update_project_view_model.dart'
    as _i439;
import '../services/firebase_service.dart' as _i758;
import '../services/firebase_service_impl.dart' as _i704;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i758.FirebaseService>(() => _i704.FirebaseServiceImpl());
    gh.factory<_i425.AddJobRemoteDataSource>(
      () => _i598.AddJobRemoteDataSourceImpl(gh<_i758.FirebaseService>()),
    );
    gh.factory<_i190.AddProjectRemoteDataSource>(
      () => _i1047.AddProjectRemoteDataSourceImpl(gh<_i758.FirebaseService>()),
    );
    gh.factory<_i694.DeleteProjectRemoteDataSource>(
      () =>
          _i487.DeleteProjectRemoteDataSourceImpl(gh<_i758.FirebaseService>()),
    );
    gh.factory<_i585.AddOpportunityRemoteDataSource>(
      () =>
          _i939.AddOpportunityRemoteDataSourceImpl(gh<_i758.FirebaseService>()),
    );
    gh.factory<_i45.AddProjectRepository>(
      () =>
          _i63.AddProjectRepositoryImpl(gh<_i190.AddProjectRemoteDataSource>()),
    );
    gh.factory<_i107.DeleteJobRemoteDataSource>(
      () => _i370.DeleteJobRemoteDataSourceImpl(gh<_i758.FirebaseService>()),
    );
    gh.factory<_i1046.BannersRemoteDataSource>(
      () => _i576.BannersRemoteDataSourceImpl(gh<_i758.FirebaseService>()),
    );
    gh.factory<_i131.GetProjectDetailsRemoteDataSource>(
      () => _i379.GetProjectDetailsRemoteDataSourceImpl(
        gh<_i758.FirebaseService>(),
      ),
    );
    gh.factory<_i822.DeleteProjectRepository>(
      () => _i687.DeleteProjectRepositoryImpl(
        gh<_i694.DeleteProjectRemoteDataSource>(),
      ),
    );
    gh.factory<_i440.UpdateProjectRemoteDataSource>(
      () =>
          _i394.UpdateProjectRemoteDataSourceImpl(gh<_i758.FirebaseService>()),
    );
    gh.factory<_i804.GetAllProjectsRemoteDataSource>(
      () =>
          _i113.GetAllProjectsRemoteDataSourceImpl(gh<_i758.FirebaseService>()),
    );
    gh.factory<_i168.GetProjectsByCategoryRemoteDataSource>(
      () => _i570.GetProjectsByCategoryRemoteDataSourceImpl(
        gh<_i758.FirebaseService>(),
      ),
    );
    gh.factory<_i104.GetJobByIdRemoteDataSource>(
      () => _i12.GetJobByIdRemoteDataSourceImpl(gh<_i758.FirebaseService>()),
    );
    gh.factory<_i563.GetAllOpportunitiesRemoteDataSource>(
      () => _i501.GetAllOpportunitiesRemoteDataSourceImpl(
        gh<_i758.FirebaseService>(),
      ),
    );
    gh.factory<_i943.UpdateProjectRepository>(
      () => _i1018.UpdateProjectRepositoryImpl(
        gh<_i440.UpdateProjectRemoteDataSource>(),
      ),
    );
    gh.factory<_i847.GetAllJobsRemoteDataSource>(
      () => _i969.GetAllJobsRemoteDataSourceImpl(gh<_i758.FirebaseService>()),
    );
    gh.factory<_i272.GetAllOpportunitiesRepo>(
      () => _i134.GetAllOpportunitiesRepoImpl(
        gh<_i563.GetAllOpportunitiesRemoteDataSource>(),
      ),
    );
    gh.factory<_i903.GetAllJobsRepo>(
      () => _i394.GetAllJobsRepoImpl(gh<_i847.GetAllJobsRemoteDataSource>()),
    );
    gh.factory<_i786.CategoryRemoteDataSource>(
      () => _i924.CategoryRemoteDataSourceImpl(gh<_i758.FirebaseService>()),
    );
    gh.factory<_i925.GetAllProjectsRepository>(
      () => _i528.GetAllProjectsRepositoryImpl(
        gh<_i804.GetAllProjectsRemoteDataSource>(),
      ),
    );
    gh.factory<_i508.GetAllProjectsUseCase>(
      () => _i508.GetAllProjectsUseCase(gh<_i925.GetAllProjectsRepository>()),
    );
    gh.factory<_i180.AddProjectUseCase>(
      () => _i180.AddProjectUseCase(gh<_i45.AddProjectRepository>()),
    );
    gh.factory<_i572.BannersRepository>(
      () => _i203.BannersReposImpl(gh<_i1046.BannersRemoteDataSource>()),
    );
    gh.factory<_i329.DeleteProjectUseCase>(
      () => _i329.DeleteProjectUseCase(gh<_i822.DeleteProjectRepository>()),
    );
    gh.factory<_i369.BannerUseCase>(
      () => _i369.BannerUseCase(gh<_i572.BannersRepository>()),
    );
    gh.factory<_i907.GetAllProjectsViewModel>(
      () => _i907.GetAllProjectsViewModel(gh<_i508.GetAllProjectsUseCase>()),
    );
    gh.factory<_i569.AddJobRepo>(
      () => _i971.AddJobRepoImpl(gh<_i425.AddJobRemoteDataSource>()),
    );
    gh.factory<_i1066.CategoryRepos>(
      () => _i672.CategoryReposImpl(gh<_i786.CategoryRemoteDataSource>()),
    );
    gh.factory<_i61.AddNewServiceViewModel>(
      () => _i61.AddNewServiceViewModel(gh<_i180.AddProjectUseCase>()),
    );
    gh.factory<_i943.DeleteProjectViewModel>(
      () => _i943.DeleteProjectViewModel(gh<_i329.DeleteProjectUseCase>()),
    );
    gh.factory<_i686.DeleteJobRepo>(
      () => _i664.DeleteJobRepoImpl(gh<_i107.DeleteJobRemoteDataSource>()),
    );
    gh.factory<_i495.AddOpportunityRepo>(
      () => _i658.AddOpportunityRepoImpl(
        gh<_i585.AddOpportunityRemoteDataSource>(),
      ),
    );
    gh.factory<_i886.CategoryUseCase>(
      () => _i886.CategoryUseCase(gh<_i1066.CategoryRepos>()),
    );
    gh.factory<_i76.GetBannersByPositionViewModel>(
      () => _i76.GetBannersByPositionViewModel(
        bannerUseCase: gh<_i369.BannerUseCase>(),
      ),
    );
    gh.factory<_i184.GetProjectDetailsRepository>(
      () => _i80.GetProjectDetailsRepositoryImpl(
        gh<_i131.GetProjectDetailsRemoteDataSource>(),
      ),
    );
    gh.factory<_i772.GetAllJobsUsecase>(
      () => _i772.GetAllJobsUsecase(gh<_i903.GetAllJobsRepo>()),
    );
    gh.factory<_i250.GetProjectsByCategoryRepository>(
      () => _i61.GetProjectsByCategoryRepositoryImpl(
        gh<_i168.GetProjectsByCategoryRemoteDataSource>(),
      ),
    );
    gh.factory<_i645.UpdateProjectUseCase>(
      () => _i645.UpdateProjectUseCase(gh<_i943.UpdateProjectRepository>()),
    );
    gh.factory<_i108.GetJobByIdRepo>(
      () => _i93.GetJobByIdRepoImpl(gh<_i104.GetJobByIdRemoteDataSource>()),
    );
    gh.factory<_i966.GetProjectDetailsUsecase>(
      () => _i966.GetProjectDetailsUsecase(
        gh<_i184.GetProjectDetailsRepository>(),
      ),
    );
    gh.factory<_i365.GetAllOpportunitiesUsecase>(
      () =>
          _i365.GetAllOpportunitiesUsecase(gh<_i272.GetAllOpportunitiesRepo>()),
    );
    gh.factory<_i616.GetProjectDetailsViewModel>(
      () => _i616.GetProjectDetailsViewModel(
        gh<_i966.GetProjectDetailsUsecase>(),
      ),
    );
    gh.factory<_i117.GetJobByIdUsecase>(
      () => _i117.GetJobByIdUsecase(gh<_i108.GetJobByIdRepo>()),
    );
    gh.factory<_i203.AddOpportunityUsecase>(
      () => _i203.AddOpportunityUsecase(gh<_i495.AddOpportunityRepo>()),
    );
    gh.factory<_i1047.AddJobUsecase>(
      () => _i1047.AddJobUsecase(gh<_i569.AddJobRepo>()),
    );
    gh.factory<_i654.GetProjectsByCategoryUseCase>(
      () => _i654.GetProjectsByCategoryUseCase(
        gh<_i250.GetProjectsByCategoryRepository>(),
      ),
    );
    gh.factory<_i696.GetProjectsByCategoryViewModel>(
      () => _i696.GetProjectsByCategoryViewModel(
        gh<_i654.GetProjectsByCategoryUseCase>(),
      ),
    );
    gh.factory<_i111.DeleteJobUsecase>(
      () => _i111.DeleteJobUsecase(gh<_i686.DeleteJobRepo>()),
    );
    gh.factory<_i623.GetAllCategoriesViewModel>(
      () => _i623.GetAllCategoriesViewModel(gh<_i886.CategoryUseCase>()),
    );
    gh.factory<_i29.GetAllJobsViewModel>(
      () => _i29.GetAllJobsViewModel(gh<_i772.GetAllJobsUsecase>()),
    );
    gh.factory<_i439.UpdateProjectViewModel>(
      () => _i439.UpdateProjectViewModel(gh<_i645.UpdateProjectUseCase>()),
    );
    gh.factory<_i1068.GetAllOpportunitiesViewModel>(
      () => _i1068.GetAllOpportunitiesViewModel(
        gh<_i365.GetAllOpportunitiesUsecase>(),
      ),
    );
    gh.factory<_i640.AddJobViewModel>(
      () => _i640.AddJobViewModel(gh<_i1047.AddJobUsecase>()),
    );
    gh.factory<_i1036.AddOpportunityViewModel>(
      () => _i1036.AddOpportunityViewModel(gh<_i203.AddOpportunityUsecase>()),
    );
    return this;
  }
}
