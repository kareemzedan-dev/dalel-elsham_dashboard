import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../config/routes/routes_manager.dart';
import 'drawer_header_section.dart';
import 'drawer_item.dart';
import 'logout_button.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DrawerHeaderSection(),

        Expanded(
          child: ListView(
            padding: EdgeInsets.only(top: 16.h),
            children: [
              DrawerItem(
                icon: Icons.dashboard,
                title: 'اداره المشاريع الجديده',
                onTap: () {
                 // Navigator.pushNamed(context, Routes.newOrdersScreen);
                },
              ),

              DrawerItem(
                icon: Icons.campaign,
                title: 'إدارة الإعلانات',
                onTap: () {
               //   Navigator.pushNamed(context, Routes.manageBannersScreen);
                },
              ),

              DrawerItem(
                icon: Icons.home_repair_service,
                title: 'إدارة الخدمات / المشاريع',
                onTap: () {
                //  Navigator.pushNamed(context, Routes.manageServicesScreen);
                },
              ),

              DrawerItem(
                icon: Icons.people_alt,
                title: 'إدارة المستخدمين',
                onTap: () {
               //   Navigator.pushNamed(context, Routes.usersScreen);
                },
              ),

              DrawerItem(
                icon: Icons.report,
                title: 'البلاغات والشكاوى',
                onTap: () {
               //   Navigator.pushNamed(context, Routes.reportsScreen);
                },
              ),

              DrawerItem(
                icon: Icons.settings,
                title: 'الإعدادات',
                onTap: () {
//Navigator.pushNamed(context, Routes.settingsScreen);
                },
              ),
            ],
          ),
        ),

        LogoutButton(
          onTap: () {
            // عملية تسجيل الخروج
          },
        ),

        SizedBox(height: 16.h),
      ],
    );
  }
}
