import 'package:bloc/bloc.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/azkar/domain/entities/azkar_entity.dart';
import 'package:film/features/tabs/azkar/domain/use_cases/wakingUp_from_Sleep_azkar_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'azkar_state.dart';

// azkar_cubit.dart
@injectable
class AzkarCubit extends Cubit<AzkarState> {
  final GetAllAzkarCategoriesUseCase _getAllCategoriesUseCase;
  final GetAzkarByCategoryUseCase _getAzkarByCategoryUseCase;

  AzkarCubit(
    this._getAllCategoriesUseCase,
    this._getAzkarByCategoryUseCase,
  ) : super(AzkarInitial());

  Future<void> loadAllCategories() async {
    emit(AzkarLoading());
    final result = await _getAllCategoriesUseCase();
    result.fold(
      (failure) => emit(AzkarError(failure)),
      (categories) => emit(AzkarCategoriesLoaded(categories)),
    );
  }

  Future<void> loadAzkarByCategory(String categoryId) async {
    emit(AzkarLoading());
    final result = await _getAzkarByCategoryUseCase(categoryId);
    result.fold(
      (failure) => emit(AzkarError(failure)),
      (azkar) => emit(AzkarLoaded(azkar)),
    );
  }
}
