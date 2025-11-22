import 'package:dlyl_alsham_dashboard/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../core/di/di.dart';
import '../manager/app_links/get_all_app_links_view_model/get_all_app_links_view_model.dart';
import '../manager/app_links/get_all_app_links_view_model/get_all_app_links_view_model_states.dart';
import '../manager/app_links/add_or_update_link_view_model/add_or_update_link_view_model.dart';
import '../manager/app_links/add_or_update_link_view_model/add_or_update_link_view_model_states.dart';

import '../../domain/entities/app_link_entity.dart';

class LinksManagementViewBody extends StatefulWidget {
  const LinksManagementViewBody({super.key});

  @override
  State<LinksManagementViewBody> createState() =>
      _LinksManagementViewBodyState();
}

class _LinksManagementViewBodyState extends State<LinksManagementViewBody> {
  /// ============== CONTROLLERS ==============
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();

  final TextEditingController appStoreController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  /// IDs لو موجود روابط بالفعل نستخدم IDs عشان نعمل update مش add
  String facebookId = "";
  String instagramId = "";
  String youtubeId = "";
  String twitterId = "";

  String appStoreId = "";
  String reviewId = "";

  String phoneId = "";
  String emailId = "";

  @override
  void initState() {
    super.initState();
    context.read<GetAllAppLinksViewModel>().getAllAppLinks().then((value) {
      value.fold(
        ifLeft: (l) {},
        ifRight: (links) {
          for (var link in links) {
            switch (link.type) {
              case "facebook":
                facebookId = link.id;
                facebookController.text = link.url;
                break;
              case "instagram":
                instagramId = link.id;
                instagramController.text = link.url;
                break;
              case "youtube":
                youtubeId = link.id;
                youtubeController.text = link.url;
                break;
              case "twitter":
                twitterId = link.id;
                twitterController.text = link.url;
                break;
              case "share_app":
                appStoreId = link.id;
                appStoreController.text = link.url;
                break;
              case "review":
                reviewId = link.id;
                reviewController.text = link.url;
                break;
              case "phone":
                phoneId = link.id;
                phoneController.text = link.url;
                break;
              case "email":
                emailId = link.id;
                emailController.text = link.url;
                break;
            }
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      AddOrUpdateLinkViewModel,
      AddOrUpdateLinkViewModelStates
    >(
      listener: (context, state) {
        if (state is AddOrUpdateLinkViewModelStatesSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("تم حفظ الروابط بنجاح"),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is AddOrUpdateLinkViewModelStatesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// =======================
                ///       سوشيال ميديا
                /// =======================
                _buildLabel("روابط التواصل الاجتماعي"),
                SizedBox(height: 15.h),

                _buildTextField("فيسبوك", facebookController),
                SizedBox(height: 12.h),

                _buildTextField("إنستغرام", instagramController),
                SizedBox(height: 12.h),

                _buildTextField("يوتيوب", youtubeController),
                SizedBox(height: 12.h),

                _buildTextField("تويتر / X", twitterController),
                SizedBox(height: 25.h),

                /// =======================
                ///     روابط التطبيق
                /// =======================
                _buildLabel("روابط التطبيق"),
                SizedBox(height: 15.h),

                _buildTextField("رابط التطبيق على المتجر", appStoreController),
                SizedBox(height: 12.h),

                _buildTextField("رابط تقييم التطبيق", reviewController),
                SizedBox(height: 25.h),

                /// =======================
                ///     معلومات التواصل
                /// =======================
                _buildLabel("معلومات التواصل"),
                SizedBox(height: 15.h),

                _buildTextField("رقم الهاتف", phoneController),
                SizedBox(height: 12.h),

                _buildTextField("البريد الإلكتروني", emailController),
                SizedBox(height: 25.h),

                /// =======================
                /// زر الحفظ
                /// =======================
                _buildSaveButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// عنوان
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    );
  }

  /// TextField
  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
          ),
        ),
      ],
    );
  }

  /// زر الحفظ
  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final viewModel = context.read<AddOrUpdateLinkViewModel>();

          final allLinks = [
            AppLinkEntity(
              id: facebookId,
              type: "facebook",
              title: "Facebook",
              url: facebookController.text,
            ),
            AppLinkEntity(
              id: instagramId,
              type: "instagram",
              title: "Instagram",
              url: instagramController.text,
            ),
            AppLinkEntity(
              id: youtubeId,
              type: "youtube",
              title: "YouTube",
              url: youtubeController.text,
            ),
            AppLinkEntity(
              id: twitterId,
              type: "twitter",
              title: "Twitter",
              url: twitterController.text,
            ),
            AppLinkEntity(
              id: appStoreId,
              type: "share_app",
              title: "share_app",
              url: appStoreController.text,
            ),
            AppLinkEntity(
              id: reviewId,
              type: "review",
              title: "Review",
              url: reviewController.text,
            ),
            AppLinkEntity(
              id: phoneId,
              type: "phone",
              title: "Phone",
              url: phoneController.text,
            ),
            AppLinkEntity(
              id: emailId,
              type: "email",
              title: "Email",
              url: emailController.text,
            ),
          ];

          viewModel.emit(AddOrUpdateLinkViewModelStatesLoading());

          final results = await Future.wait(
            allLinks.map(
              (e) => viewModel.addOrUpdateLinkUseCase.addOrUpdateLink(e),
            ),
          );

          for (var res in results) {
            if (res.isLeft) {
              final msg = res.fold(
                ifLeft: (fail) => fail.message,
                ifRight: (r) => null,
              );
              return viewModel.emit(
                AddOrUpdateLinkViewModelStatesError(message: msg.toString()),
              );
            }
          }

          viewModel.emit(AddOrUpdateLinkViewModelStatesSuccess());
        },

        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          backgroundColor: ColorsManager.primaryColor,
        ),
        child:
            BlocBuilder<
              AddOrUpdateLinkViewModel,
              AddOrUpdateLinkViewModelStates
            >(
              builder: (context, state) {
                if (state is AddOrUpdateLinkViewModelStatesLoading) {
                  return const CircularProgressIndicator(color: Colors.white);
                }
                return Text(
                  "حفظ الروابط",
                  style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp
                  ),
                );
              },
            ),
      ),
    );
  }
}
