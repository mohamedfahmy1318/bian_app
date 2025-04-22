// lib/features/sebha/domain/use_cases/reset_sebha_use_case.dart
import 'package:dartz/dartz.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/sebha/domain/repositories/sebha_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetSebhaUseCase {
  final SebhaRepository _repository;

  ResetSebhaUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return _repository.resetSebha(params);
  }
}
