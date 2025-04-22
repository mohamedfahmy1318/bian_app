part of 'sebha_cubit.dart';

@immutable
sealed class SebhaState {}

final class SebhaInitial extends SebhaState {}

class SebhaLoading extends SebhaState {}

class SebhaLoaded extends SebhaState {
  final List<SebhaEntity> sebhaList;
  SebhaLoaded(this.sebhaList);
}

class SebhaError extends SebhaState {
  final String message;
  SebhaError(this.message);
}
