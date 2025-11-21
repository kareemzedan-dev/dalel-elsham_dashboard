import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/jobs/get_all_jobs_view_model/get_all_jobs_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/Job_opportunities_view_body_management.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/job_opportunities_view_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/enums/request_type.dart';
import '../manager/jobs/get_all_jobs_view_model/get_all_jobs_view_model_states.dart';
import '../manager/jobs/get_all_opportunities_view_model/get_all_opportunities_view_model.dart';
import '../manager/jobs/get_all_opportunities_view_model/get_all_opportunities_view_model_states.dart';

class JobOpportunitiesViewManagement extends StatelessWidget {
  JobOpportunitiesViewManagement({super.key, this.title, required this.type});

  String? title;
  final RequestType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title!),
      body: type == RequestType.job
          ? BlocProvider(
              create: (context) => getIt<GetAllJobsViewModel>()..getAllJobs(),
              child:
                  BlocBuilder<GetAllJobsViewModel, GetAllJobsViewModelStates>(
                    builder: (context, state) {
                      if (state is GetAllJobsViewModelLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is GetAllJobsViewModelSuccess) {
                        if (state.jobs.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  "assets/lottie/empty.json",
                                  height: 200.h,
                                  width: 200.w,
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "لا يوجد طلبات عمل",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return JobOpportunitiesViewBodyManagement(
                          jobs: state.jobs,
                          onTap: (index) {
                            Navigator.pushNamed(
                              context,
                              RoutesManager.adminJobRequestDetails,
                              arguments: {
                                "job": state.jobs[index],
                                "title": "تفاصيل طلبات العمل",
                                "type": RequestType.job,
                              },
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
            )
          : BlocProvider(
              create: (context) =>
                  getIt<GetAllOpportunitiesViewModel>()..getAllOpportunities(),
              child:
                  BlocBuilder<
                    GetAllOpportunitiesViewModel,
                    GetAllOpportunitiesViewModelStates
                  >(
                    builder: (context, state) {
                      if (state is GetAllOpportunitiesViewModelLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is GetAllOpportunitiesViewModelSuccess) {
                        if (state.jobs.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  "assets/lottie/empty.json",
                                  height: 200.h,
                                  width: 200.w,
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "لا يوجد فرص عمل",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return JobOpportunitiesViewBodyManagement(
                          jobs: state.jobs,
                          onTap: (index) {
                            Navigator.pushNamed(
                              context,
                              RoutesManager.adminJobRequestDetails,
                              arguments: {
                                "job": state.jobs[index],
                                "title": "تفاصيل فرص العمل",
                                "type": RequestType.opportunity,
                              },
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
            ),
    );
  }
}
