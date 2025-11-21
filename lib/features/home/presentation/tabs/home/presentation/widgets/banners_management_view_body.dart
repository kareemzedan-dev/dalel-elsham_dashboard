import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/banners/get_banners_by_position_view_model/get_banners_by_position_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/banners/get_banners_by_position_view_model/get_banners_by_position_view_model_states.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/banner_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/di/di.dart';

class BannersManagementViewBody extends StatelessWidget {
  const BannersManagementViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ------------------ الشاشة الرئيسية ------------------
            _buildLabel("بانرات الشاشة الرئيسية"),
            SizedBox(height: 16.h),
            _bannerSection("home", (bannerId) {}),

            SizedBox(height: 60.h),

            /// ------------------ فرص عمل ------------------
            _buildLabel("بانرات فرص عمل"),
            SizedBox(height: 16.h),
            _bannerSection("opportunities", (bannerId) {}),

            SizedBox(height: 60.h),

            /// ------------------ طلبات عمل ------------------
            _buildLabel("بانرات طلبات العمل"),
            SizedBox(height: 16.h),
            _bannerSection("job_seekers", (bannerId) {}),

            SizedBox(height: 60.h),

            /// ------------------ دليل الشام ------------------
            _buildLabel("بانرات دليل الشام"),
            SizedBox(height: 16.h),
            _bannerSection("dalel_al_sham", (bannerId) {}),

            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }

  /// ------------------ Widget لطلب البانرات حسب المكان ------------------
  Widget _bannerSection(String position, Function(String bannerId)? onDelete) {
    return BlocProvider(
      create: (context) =>
          getIt<GetBannersByPositionViewModel>()
            ..getBannersByPosition(position),
      child:
          BlocBuilder<
            GetBannersByPositionViewModel,
            GetBannersByPositionViewModelStates
          >(
            builder: (context, state) {
              if (state is GetBannersByPositionViewModelStatesLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is GetBannersByPositionViewModelStatesError) {
                return Center(
                  child: Text(
                    "حدث خطأ في تحميل البانرات",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }

              if (state is GetBannersByPositionViewModelStatesSuccess) {
                if (state.banners.isEmpty) {
                  return Center(
                    child: Text(
                      "لا يوجد بانرات هنا",
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                  );
                }

                return BannerSection(
                  images: state.banners,
                  disableAutoPlay: true,
                  onDelete: onDelete,
                );
              }

              return SizedBox();
            },
          ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    );
  }
}
