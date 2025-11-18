import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/components/custom_app_bar.dart';
import '../widgets/admin_project_edit_view_body.dart';

class AdminProjectEditView extends StatelessWidget {
  const AdminProjectEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        title: "تعديل المشروع",

      ),
      body: const AdminProjectEditViewBody(),
    );
}
}
