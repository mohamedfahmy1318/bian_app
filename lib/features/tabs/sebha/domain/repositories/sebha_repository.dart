// lib/features/sebha/domain/repositories/sebha_repository.dart
import 'package:dartz/dartz.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/sebha/domain/entities/sebha_entity.dart';

abstract class SebhaRepository {
  Future<Either<Failure, List<SebhaEntity>>> getAllSebha();
  Future<Either<Failure, void>> incrementSebha(SebhaEntity sebha);
  Future<Either<Failure, void>> resetSebha(String id);
}
