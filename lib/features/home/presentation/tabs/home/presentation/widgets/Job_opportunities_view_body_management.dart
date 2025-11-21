import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/assets_manager.dart';
import '../../domain/entities/job_entity.dart';
import 'Job_seeker_card_list.dart';
import 'job_management_card.dart';
import 'job_management_card_list.dart';

class JobOpportunitiesViewBodyManagement extends StatelessWidget {
  const JobOpportunitiesViewBodyManagement({super.key, required this.jobs, required this.onTap});
  final List<JobEntity> jobs;
  final Function(int) onTap;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(children: [
          JobManagementCardList(
            jobs: jobs,
            onTap: onTap,
          )

        ]),
      ),
    );
  }
}
