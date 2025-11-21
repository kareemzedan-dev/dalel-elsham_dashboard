import 'package:flutter/cupertino.dart';

import '../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../core/utils/assets_manager.dart';
import '../../domain/entities/job_entity.dart';
import 'job_management_card.dart';

class JobManagementCardList extends StatelessWidget {
  const JobManagementCardList({super.key, required this.jobs, required this.onTap});
  final List<JobEntity> jobs;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount:  jobs.length,
      itemBuilder: (context, index) {
        return   Padding(
          padding: const EdgeInsets.symmetric(vertical:  8.0),
          child: JobManagementCard(
            entity: jobs[index],
            onTap: () => onTap(index),

          ),
        );
      },
    );
  }
}
