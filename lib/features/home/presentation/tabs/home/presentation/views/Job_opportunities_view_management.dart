import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/Job_opportunities_view_body_management.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/job_opportunities_view_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/components/custom_app_bar.dart';

class JobOpportunitiesViewManagement extends StatelessWidget {
  const JobOpportunitiesViewManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(title: "اداره فرص العمل",),
      body: const JobOpportunitiesViewBodyManagement(),
    );
  }
}
