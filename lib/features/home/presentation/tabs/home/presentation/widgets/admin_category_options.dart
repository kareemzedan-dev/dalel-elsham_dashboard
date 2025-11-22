import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../core/components/confirmation_dialog.dart';
import '../../../../../../../core/di/di.dart';
import '../../domain/entities/category_entity.dart';
import '../manager/categories/delete_category_view_model/delete_category_view_model.dart';
import '../manager/categories/delete_category_view_model/delete_category_view_model_states.dart';
import '../manager/categories/update_category_view_model/update_category_view_model.dart';
import 'edit_category_sheet.dart';
class AdminCategoryOptions extends StatelessWidget {
  const AdminCategoryOptions({
    super.key,
    required this.category,
    required this.parentContext, // ← context الحقيقي جاي من الأب
  });

  final CategoryEntity category;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text("تعديل الفئة"),
          onTap: () {
            Navigator.pop(context);

            showModalBottomSheet(
              context: parentContext,
              isScrollControlled: true,
              builder: (_) => BlocProvider(
                create: (_) => getIt<UpdateCategoryViewModel>(),
                child: EditCategorySheet(category: category),
              ),
            );
          },
        ),

        ListTile(
          leading: const Icon(Icons.delete, color: Colors.red),
          title: const Text("حذف الفئة"),
          onTap: () {
            Navigator.pop(context);

            showConfirmationDialog(
              context: parentContext,
              title: "حذف الفئة",
              message: "هل أنت متأكد من الحذف؟",
              onConfirm: () {

                parentContext
                    .read<DeleteCategoryViewModel>()
                    .deleteCategory(category.id);

              },
            );
          },
        ),
      ],
    );
  }
}
