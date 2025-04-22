import 'package:dartz/dartz.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/sebha/data/data_sources/local_sebha_data_source.dart';
import 'package:film/features/tabs/sebha/data/models/sebha_hive_model.dart';
import 'package:film/features/tabs/sebha/domain/entities/sebha_entity.dart';
import 'package:film/features/tabs/sebha/domain/repositories/sebha_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SebhaRepository)
class SebhaRepositoryImpl implements SebhaRepository {
  final LocalSebhaDataSource _dataSource;

  SebhaRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<SebhaEntity>>> getAllSebha() async {
    try {
      final models = await _dataSource.getAllSebha();
      return Right(models.map(_mapToEntity).toList());
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load tasbih: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> incrementSebha(SebhaEntity sebha) async {
    try {
      // Ensure we're passing the same ID when updating
      await _dataSource.saveSebha(_mapToModel(sebha.copyWith(
        count: sebha.count + 1,
        lastUpdated: DateTime.now(),
      )));
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to increment: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> resetSebha(String id) async {
    try {
      await _dataSource.resetSebha(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to reset: $e'));
    }
  }

  SebhaEntity _mapToEntity(SebhaHiveModel model) => SebhaEntity(
        id: model.id,
        title: model.title,
        dhikr: model.dhikr,
        count: model.count,
        target: model.target,
        lastUpdated: model.lastUpdated,
        isCountable: model.isCountable,
      );

  SebhaHiveModel _mapToModel(SebhaEntity entity) => SebhaHiveModel(
        id: entity.id,
        title: entity.title,
        dhikr: entity.dhikr,
        count: entity.count,
        target: entity.target,
        lastUpdated: entity.lastUpdated,
        isCountable: entity.isCountable,
      );
}
