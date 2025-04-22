// lib/features/sebha/domain/use_cases/increment_sebha_use_case.dart
import 'package:dartz/dartz.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/sebha/domain/entities/sebha_entity.dart';
import 'package:film/features/tabs/sebha/domain/repositories/sebha_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class IncrementSebhaUseCase {
  final SebhaRepository repository;

  IncrementSebhaUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SebhaEntity params) async {
    return await repository.incrementSebha(params);
  }
}
