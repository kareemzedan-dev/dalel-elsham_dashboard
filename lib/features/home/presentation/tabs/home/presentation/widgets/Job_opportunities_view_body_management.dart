import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/assets_manager.dart';
import 'Job_seeker_card_list.dart';
import 'job_management_card.dart';

class JobOpportunitiesViewBodyManagement extends StatelessWidget {
  const JobOpportunitiesViewBodyManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            JobManagementCard(
              name: "محمد القاسم",
              description:
              "ابحث عن عمل كمصمم جرافيك، لدي خبرة 4 سنوات في تصميم الشعارات والإعلانات.",
              location: "دمشق",
              date: "12/11/2025",
              imagePath: AssetsManager.person,

            )



          ],
        ),
      ),
    );
  }
}
