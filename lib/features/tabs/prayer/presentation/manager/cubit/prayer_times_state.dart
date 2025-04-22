part of 'prayer_times_cubit.dart';

@immutable
sealed class PrayerTimesState {}

class PrayerTimesInitial extends PrayerTimesState {}

class PrayerTimesLoading extends PrayerTimesState {}

class PrayerTimesLoaded extends PrayerTimesState {
  final PrayTimeEntity times;
  PrayerTimesLoaded({required this.times});
}

class PrayerTimesError extends PrayerTimesState {
  final Failure message;
  PrayerTimesError({required this.message});
}
