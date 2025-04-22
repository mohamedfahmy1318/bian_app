// lib/features/sebha/domain/use_cases/get_sebha_count_use_case.dart
import 'package:dartz/dartz.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/sebha/domain/entities/sebha_entity.dart';
import 'package:film/features/tabs/sebha/domain/repositories/sebha_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSebhaCountUseCase {
  final SebhaRepository _repository;

  GetSebhaCountUseCase(this._repository);

  @override
  Future<Either<Failure, List<SebhaEntity>>> call() {
    return _repository.getAllSebha();
  }
}
