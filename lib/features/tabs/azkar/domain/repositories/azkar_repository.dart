// azkar_repository.dart
import 'package:dartz/dartz.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/azkar/domain/entities/azkar_entity.dart';

abstract class AzkarRepository {
  Future<Either<Failure, List<AzkarEntity>>> getAzkarByCategory(
      String categoryId);
}
