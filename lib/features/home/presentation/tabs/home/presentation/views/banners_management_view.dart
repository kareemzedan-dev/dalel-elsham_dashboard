import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/components/add_floating_button.dart';
import '../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../core/di/di.dart';
import '../manager/banners/add_banner_view_model/add_banner_view_model.dart';
import '../manager/banners/delete_banner_view_model/delete_banner_view_model.dart';
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
            builder: (context) =>   BlocProvider(
                create: (context) => getIt<AddBannerViewModel>(),
                child: BannersModelSheetContent()),
          );

        },
      ),
      appBar: const CustomAppBar(title: "اداره البانرات"),
      body: BlocProvider(
          create: (context) => getIt<DeleteBannerViewModel>(),
          child:    BannersManagementViewBody()),
    );
  }
}
