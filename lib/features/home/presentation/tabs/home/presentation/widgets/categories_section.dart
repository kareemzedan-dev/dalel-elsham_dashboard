import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/utils/colors_manager.dart';
import '../../domain/entities/category_entity.dart';
import '../manager/categories/add_category_view_model/add_category_view_model.dart';
import '../manager/categories/delete_category_view_model/delete_category_view_model.dart';
import 'add_category_sheet.dart';
import 'category_item_list.dart';
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    required this.categoriesList,
    this.isAdmin = false,
  });

  final List<CategoryEntity> categoriesList;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DeleteCategoryViewModel>(),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "تصفح حسب :",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),



            if (isAdmin)
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => BlocProvider(
                      create: (_) => getIt<AddCategoryViewModel>(),
                      child: const AddCategorySheet(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 5),
                      Text("إضافة", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              )
          ],
        ),

          SizedBox(height: 16.h),

        /// أهم جزء في الحل 🔥🔥🔥
        /// هنا CategoryItemList أصبح تحت Provider delete
        CategoryItemList(
          categoriesList: categoriesList,
          isAdmin: isAdmin,
        ),
      ],
    );
  }
}
