import 'package:dlyl_alsham_dashboard/core/errors/failures.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/entities/project_display_section_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract class ProjectDisplaySectionsRepository {
  Future<Either<Failures, List<ProjectDisplaySectionEntity>>>
  getAllProjectDisplaySections();

  Future<Either<Failures, void>> addProjectDisplaySection(
    ProjectDisplaySectionEntity projectDisplaySectionEntity,
  );

  Future<Either<Failures, void>> updateProjectDisplaySection(
    ProjectDisplaySectionEntity projectDisplaySectionEntity,
  );

  Future<Either<Failures, void>> deleteProjectDisplaySection(String id);

  Future<Either<Failures, void>> addProjectToSection(
    String projectId,
    String sectionId,
  );
}
