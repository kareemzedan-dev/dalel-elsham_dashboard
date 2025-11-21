import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/projects_list.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/section_widget.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/services_section.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/top_bar_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/assets_manager.dart';
import 'banner_section.dart';
import 'categories_section.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarSection(),
              SizedBox(height: 30.h),
              // BannerSection(
              //   images: [
              //     AssetsManager.banner,
              //     AssetsManager.banner2,
              //   ],
              //   onAddBanner: () {
              //
              //     showModalBottomSheet(
              //       context: context,
              //       builder: (_) => SizedBox(
              //         height: 200,
              //         child: Center(
              //           child: Text("هنا هتحط UI رفع الإعلان"),
              //         ),
              //       ),
              //     );
              //   },
              // ),

              SizedBox(height: 30.h),
           //  CategoriesSection(),
              SectionWidget(title: "عناصر مميزه", child: ProjectsList()),
              SizedBox(height: 30.h),
              ServicesSection(),
              SizedBox(height: 30.h),
              SectionWidget(title: "نورونا جديد", child: ProjectsList()),
            ],
          ),
        ),
      ),
    );
  }
}
