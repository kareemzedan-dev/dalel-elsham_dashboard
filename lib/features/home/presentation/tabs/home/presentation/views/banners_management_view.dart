import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/components/add_floating_button.dart';
import '../../../../../../../core/components/custom_app_bar.dart';
import '../widgets/banners_management_view_body.dart';
import '../widgets/banners_model_sheet_content.dart';

class  BannersManagementView extends StatelessWidget {
  const  BannersManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: AddFloatingButton(
        label: 'أضف بانر',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) =>   BannersModelSheetContent(),
          );

        },
      ),
      appBar: const CustomAppBar(title: "اداره البانرات"),
      body: const BannersManagementViewBody(),
    );
  }
}
