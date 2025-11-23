import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../core/di/di.dart';
import '../manager/add_place_view_model/add_place_view_model.dart';
import '../manager/delete_place_view_model/delete_place_view_model.dart';
import '../manager/delete_place_view_model/delete_place_view_model_states.dart';
import '../manager/get_all_place_view_model/get_all_place_view_model.dart';
import '../manager/get_section_status_view_model/get_section_status_view_model.dart';
import '../manager/update_place_view_model/update_place_view_model.dart';
import '../manager/update_section_view_model/update_section_view_model.dart';
import '../widgets/dalel_elsham_tab_view_body.dart';

class DalelElshamTabView extends StatelessWidget {
  const DalelElshamTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "دليل الشام", showBackButton: false),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<DeletePlaceViewModel>()),
          BlocProvider(create: (context) => getIt<UpdatePlaceViewModel>()),
          BlocProvider(create: (context) => getIt<AddPlaceViewModel>()),
          BlocProvider(
            create: (context) => getIt<GetAllPlaceViewModel>()..getAllPlaces(),
          ),
          BlocProvider(
            create: (_) =>
                getIt<GetSectionStatusViewModel>()
                  ..getSectionStatus("dalel_section"),
          ),
          BlocProvider(create: (_) => getIt<UpdateSectionViewModel>()),
        ],
        child: BlocListener<DeletePlaceViewModel, DeletePlaceViewModelStates>(
          listener: (context, state) {
            if (state is DeletePlaceViewModelLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
            }

            if (state is DeletePlaceViewModelSuccess) {
              Navigator.pop(context);
              context.read<GetAllPlaceViewModel>().getAllPlaces();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم حذف المكان بنجاح"),
                  backgroundColor: Colors.green,
                ),
              );
            }

            if (state is DeletePlaceViewModelError) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("فشل الحذف: ${state.error}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const DalelElshamTabViewBody(),
        ),
      ),
    );
  }
}
