import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../core/di/di.dart';
import '../manager/app_links/add_or_update_link_view_model/add_or_update_link_view_model.dart';
import '../manager/app_links/get_all_app_links_view_model/get_all_app_links_view_model.dart';
import '../widgets/links_management_view_body.dart';

class LinksManagementView extends StatelessWidget {
  const LinksManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "إدارة الروابط"),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<GetAllAppLinksViewModel>()),
          BlocProvider(create: (_) => getIt<AddOrUpdateLinkViewModel>()),
        ],
        child: LinksManagementViewBody(),
      )

    );
  }
}
