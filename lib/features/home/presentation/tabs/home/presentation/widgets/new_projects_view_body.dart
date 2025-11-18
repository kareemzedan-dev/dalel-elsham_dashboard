import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/pending_project_card.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/pending_projects_list.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../../config/routes/routes_manager.dart';
import 'category_project_card_list.dart';

class NewProjectsViewBody extends StatelessWidget {
  const NewProjectsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [PendingProjectsList()]),
      ),
    );
  }
}
