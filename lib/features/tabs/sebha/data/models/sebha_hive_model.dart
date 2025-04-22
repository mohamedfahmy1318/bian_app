import 'package:hive/hive.dart';

part 'sebha_hive_model.g.dart';

@HiveType(typeId: 0)
class SebhaHiveModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String dhikr;

  @HiveField(3)
  final int count;

  @HiveField(4)
  final int target;

  @HiveField(5)
  final DateTime lastUpdated;

  @HiveField(6, defaultValue: true)
  final bool isCountable;

  SebhaHiveModel({
    required this.id,
    required this.title,
    required this.dhikr,
    required this.count,
    required this.target,
    required this.lastUpdated,
    this.isCountable = true,
  });

  SebhaHiveModel copyWith({
    String? id,
    String? title,
    String? dhikr,
    int? count,
    int? target,
    DateTime? lastUpdated,
    bool? isCountable,
  }) {
    return SebhaHiveModel(
      id: id ?? this.id,
      title: title ?? this.title,
      dhikr: dhikr ?? this.dhikr,
      count: count ?? this.count,
      target: target ?? this.target,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isCountable: isCountable ?? this.isCountable,
    );
  }
}
