// lib/features/sebha/presentation/manager/cubit/sebha_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:film/features/tabs/sebha/domain/entities/sebha_entity.dart';
import 'package:film/features/tabs/sebha/domain/repositories/sebha_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'sebha_state.dart';

@injectable
class SebhaCubit extends Cubit<SebhaState> {
  final SebhaRepository _repository;

  SebhaCubit(this._repository) : super(SebhaInitial()) {
    loadSebha();
  }

  Future<void> loadSebha() async {
    emit(SebhaLoading());
    final result = await _repository.getAllSebha();
    result.fold(
      (failure) => emit(SebhaError(failure.message)),
      (sebhaList) => emit(SebhaLoaded(sebhaList)),
    );
  }

  Future<void> incrementCounter(SebhaEntity sebha) async {
    if (!sebha.isCountable) return;

    final result = await _repository.incrementSebha(sebha);
    result.fold(
      (failure) => emit(SebhaError(failure.message)),
      (_) => loadSebha(), // Refresh the list after update
    );
  }

  Future<void> resetCounter(String id) async {
    final result = await _repository.resetSebha(id);
    result.fold(
      (failure) => emit(SebhaError(failure.message)),
      (_) => loadSebha(), // Refresh the list after reset
    );
  }
}
