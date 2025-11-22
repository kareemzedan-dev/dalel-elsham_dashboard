import 'package:dlyl_alsham_dashboard/config/routes/routes_manager.dart';
import 'package:dlyl_alsham_dashboard/core/components/confirmation_dialog.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/banners/delete_banner_view_model/delete_banner_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/banners/get_banners_by_position_view_model/get_banners_by_position_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/banners/get_banners_by_position_view_model/get_banners_by_position_view_model_states.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/banner_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/di/di.dart';
import '../manager/banners/delete_banner_view_model/delete_banner_view_model_states.dart';

class BannersManagementViewBody extends StatelessWidget {
  const BannersManagementViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteBannerViewModel, DeleteBannerViewModelStates>(
      listener: (context, state) {
        if (state is DeleteBannerViewModelStatesSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("✔ تم حذف البانر بنجاح"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesManager.home,
            (route) => false,
          );
        }

        if (state is DeleteBannerViewModelStatesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("❌ حدث خطأ: ${state.message}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("بانرات الشاشة الرئيسية"),
              SizedBox(height: 16.h),
              _bannerSection("home", (bannerId) {
                showConfirmationDialog(
                  context: context,
                  title: "تأكيد الحذف",
                  message: "هل انت متأكد انك تريد حذف هذا البانر ؟",
                  onConfirm: () {
                    context.read<DeleteBannerViewModel>().deleteBanner(
                      bannerId,
                    );
                  },
                );
              }),

              SizedBox(height: 60.h),

              _buildLabel("بانرات فرص عمل"),
              SizedBox(height: 16.h),
              _bannerSection("opportunities", (bannerId) {
                showConfirmationDialog(
                  context: context,
                  title: "تأكيد الحذف",
                  message: "هل انت متأكد انك تريد حذف هذا البانر ؟",
                  onConfirm: () {
                    context.read<DeleteBannerViewModel>().deleteBanner(
                      bannerId,
                    );
                  },
                );
              }),

              SizedBox(height: 60.h),

              _buildLabel("بانرات طلبات العمل"),
              SizedBox(height: 16.h),
              _bannerSection("job_seekers", (bannerId) {
                showConfirmationDialog(
                  context: context,
                  title: "تأكيد الحذف",
                  message: "هل انت متأكد انك تريد حذف هذا البانر ؟",
                  onConfirm: () {
                    context.read<DeleteBannerViewModel>().deleteBanner(
                      bannerId,
                    );
                  },
                );
              }),

              SizedBox(height: 60.h),

              _buildLabel("بانرات دليل الشام"),
              SizedBox(height: 16.h),
              _bannerSection("dalel_al_sham", (bannerId) {
                showConfirmationDialog(
                  context: context,
                  title: "تأكيد الحذف",
                  message: "هل انت متأكد انك تريد حذف هذا البانر ؟",
                  onConfirm: () {
                    context.read<DeleteBannerViewModel>().deleteBanner(
                      bannerId,
                    );
                  },
                );
              }),

              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }

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
                return const Center(child: CircularProgressIndicator());
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

              return const SizedBox();
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
