// azkar_state.dart
part of 'azkar_cubit.dart';

@immutable
sealed class AzkarState {}

final class AzkarInitial extends AzkarState {}

class AzkarLoading extends AzkarState {}

class AzkarCategoriesLoaded extends AzkarState {
  final List<AzkarCategory> categories;
  AzkarCategoriesLoaded(this.categories);
}

class AzkarLoaded extends AzkarState {
  final List<AzkarEntity> azkar;
  AzkarLoaded(this.azkar);
}

class AzkarError extends AzkarState {
  final Failure failure;
  AzkarError(this.failure);
}

class AzkarCategory {
  final String id;
  final String title;
  final List<AzkarEntity> azkar;

  AzkarCategory({
    required this.id,
    required this.title,
    required this.azkar,
  });
}
