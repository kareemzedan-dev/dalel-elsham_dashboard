import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../config/routes/routes_manager.dart';
import '../../domain/entities/category_entity.dart';
import '../manager/categories/delete_category_view_model/delete_category_view_model.dart';
import 'category_item.dart';
import 'admin_category_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItemList extends StatelessWidget {
  const CategoryItemList({
    super.key,
    required this.categoriesList,
    this.isAdmin = false,
  });

  final List<CategoryEntity> categoriesList;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    // ⭐ ترتيب حسب order
    final sortedList = [...categoriesList]
      ..sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0));

    final double itemWidth = 100.w;
    final double itemHeight = 100.h;

    return SizedBox(
      height: itemHeight * 3 + 20.h, // 3 صفوف فقط
      child: Stack(
        children: [
          GridView.count(
            crossAxisCount: 3,           // ⭐ ثلاث صفوف فقط
            scrollDirection: Axis.horizontal,
            childAspectRatio: itemWidth / itemHeight,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            children: sortedList.map((category) {
              return CategoryItem(
                image: category.imageUrl,
                title: category.name,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesManager.categoriesDetails,
                    arguments: {
                      "categoryId": category.id,
                      "categoryName": category.name,
                    },
                  );
                },
                optionsMenu: isAdmin
                    ? () => _showAdminOptions(context, category)
                    : null,
              );
            }).toList(),
          ),

          /// Fade يمين
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 35.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0.2),
                    Colors.white,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Icon(Icons.keyboard_arrow_right,
                  color: Colors.black45, size: 24.sp),
            ),
          ),

          /// Fade شمال
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 35.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Icon(Icons.keyboard_arrow_left,
                  color: Colors.black45, size: 24.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _showAdminOptions(BuildContext context, CategoryEntity category) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<DeleteCategoryViewModel>(),
          child: AdminCategoryOptions(
            category: category,
            parentContext: context,
          ),
        );
      },
    );
  }
}
