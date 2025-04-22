class SebhaEntity {
  final String id;
  final String title;
  final String dhikr;
  final int count;
  final int target;
  final DateTime lastUpdated;
  final bool isCountable;

  SebhaEntity({
    required this.id,
    required this.title,
    required this.dhikr,
    required this.count,
    required this.target,
    required this.lastUpdated,
    required this.isCountable,
  });

  SebhaEntity copyWith({
    String? id,
    String? title,
    String? dhikr,
    int? count,
    int? target,
    DateTime? lastUpdated,
    bool? isCountable,
  }) {
    return SebhaEntity(
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
