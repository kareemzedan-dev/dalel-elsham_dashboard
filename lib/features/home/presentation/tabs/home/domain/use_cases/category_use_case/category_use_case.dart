import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../core/errors/failures.dart';
import '../../entities/category_entity.dart';
import '../../repos/category_repos/category_repos.dart';
@injectable
class CategoryUseCase {
  final CategoryRepos categoryRepos;

  CategoryUseCase(this.categoryRepos);

  Future<Either<Failures, List<CategoryEntity>>> getAllCategories() {
    return categoryRepos.getAllCategories();
  }
  Future<Either<Failures, void>> addCategory(CategoryEntity category) {
    return categoryRepos.addCategory(category);
  }
  Future<Either<Failures, void>> updateCategory(CategoryEntity category) {
    return categoryRepos.updateCategory(category);
  }
  Future<Either<Failures, void>> deleteCategory(String categoryId) {
    return categoryRepos.deleteCategory(categoryId);
  }
}