import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/dalel_elsham/presentation/widgets/sponsored_banner.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/banners/get_banners_by_position_view_model/get_banners_by_position_view_model.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/banners/get_banners_by_position_view_model/get_banners_by_position_view_model_states.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/banner_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/utils/colors_manager.dart';
import '../manager/add_place_view_model/add_place_view_model.dart';
import '../manager/delete_place_view_model/delete_place_view_model.dart';
import '../manager/get_section_status_view_model/get_section_status_view_model.dart';
import '../manager/get_section_status_view_model/get_section_status_view_model_states.dart';
import '../manager/update_place_view_model/update_place_view_model.dart';
import '../manager/update_place_view_model/update_place_view_model_states.dart';
import '../manager/update_section_view_model/update_section_view_model.dart';
import '../manager/update_section_view_model/update_section_view_model_states.dart';
import 'add_place_sheet.dart';
import 'featured_place_card_list.dart';

class DalelElshamTabViewBody extends StatefulWidget {
  const DalelElshamTabViewBody({super.key});

  @override
  State<DalelElshamTabViewBody> createState() => _DalelElshamTabViewBodyState();
}

class _DalelElshamTabViewBodyState extends State<DalelElshamTabViewBody> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateSectionViewModel, UpdateSectionViewModelStates>(
          listener: (context, state) {
            if (state is UpdateSectionViewModelSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("✔ تم تحديث حالة القسم بنجاح"),
                  backgroundColor: Colors.green,
                ),
              );
              context.read<GetSectionStatusViewModel>().getSectionStatus("dalel_section");
            }

            if (state is UpdateSectionViewModelError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("خطأ: ${state.message}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],

      child: BlocBuilder<GetSectionStatusViewModel, GetSectionStatusViewModelStates>(
        builder: (context, state) {
          if (state is GetSectionStatusViewModelLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetSectionStatusViewModelSuccess) {
            isActive = state.status;
          }

          return _buildBody(context);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "تفعيل هذا القسم",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Switch(
                      value: isActive,
                      activeColor: ColorsManager.primaryColor,
                      onChanged: (value) => _confirmToggle(context, value),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),
              const FeaturedPlaceCardList(),

              SizedBox(height: 24.h),

              Center(
                child: GestureDetector(
                  onTap: () => _openAddPlaceBottomSheet(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: ColorsManager.primaryColor,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 22.sp),
                        SizedBox(width: 6.w),
                        Text(
                          "إضافة مكان جديد",
                          style: TextStyle(color: Colors.white, fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmToggle(BuildContext context, bool newValue) async {
    final confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(newValue ? "تأكيد التفعيل" : "تأكيد الإيقاف"),
        content: Text(
          newValue
              ? "هل أنت متأكد من تفعيل هذا القسم؟"
              : "هل أنت متأكد من إيقاف هذا القسم؟",
        ),
        actions: [
          TextButton(
            child: const Text("إلغاء"),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text(
              newValue ? "تفعيل" : "إيقاف",
              style: const TextStyle(color: Colors.red),
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => isActive = newValue);

      context.read<UpdateSectionViewModel>().updateSectionStatus(
        "dalel_section",
        newValue,
      );
    }
  }

  _openAddPlaceBottomSheet(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<AddPlaceViewModel>()),
            BlocProvider(create: (_) => getIt<UpdatePlaceViewModel>()),
            BlocProvider(create: (_) => getIt<DeletePlaceViewModel>()),
          ],
          child: PlaceFormSheet(parentContext: parentContext),
        );
      },
    );
  }

}
