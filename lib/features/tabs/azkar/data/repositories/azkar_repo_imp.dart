// azkar_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/azkar/data/data_sources/remote_azkar_data_source.dart';
import 'package:film/features/tabs/azkar/domain/entities/azkar_entity.dart';
import 'package:film/features/tabs/azkar/domain/repositories/azkar_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

// azkar_repository_impl.dart
@Injectable(as: AzkarRepository)
class AzkarRepositoryImpl implements AzkarRepository {
  final RemoteAzkarDataSource _remoteDataSource;
  final Logger _logger;

  AzkarRepositoryImpl(this._remoteDataSource) : _logger = Logger();

  @override
  Future<Either<Failure, List<AzkarEntity>>> getAzkarByCategory(
      String categoryId) async {
    try {
      final azkar = await _remoteDataSource.getAzkar(categoryId);
      return Right(azkar.map((dm) => dm.toEntity()).toList());
    } on ServerFailure catch (e) {
      _logger.e('Server failure', error: e);
      return Left(e);
    } on FormatException catch (e) {
      _logger.e('Parsing failure', error: e);
      return Left(ParsingFailure(message: e.message));
    } catch (e) {
      _logger.e('Unexpected error', error: e);
      return Left(UnknownFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }
}
