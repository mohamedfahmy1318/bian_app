import 'package:film/features/tabs/azkar/domain/entities/azkar_entity.dart';

class AzkarDm {
  final int id;
  final String arabicText;
  final String? translatedText;
  final int repeat;
  final String? audio;
  final String reference;
  final String description;
  final String category;

  AzkarDm({
    required this.id,
    required this.arabicText,
    this.translatedText,
    required this.repeat,
    this.audio,
    required this.reference,
    required this.description,
    required this.category,
  });

  factory AzkarDm.fromJson(Map<String, dynamic> json) {
    return AzkarDm(
      id: json['ID'] as int,
      arabicText: json['ARABIC_TEXT'] as String,
      translatedText: json['TRANSLATED_TEXT'] as String?,
      repeat: (json['REPEAT'] as int?) ?? 1,
      audio: json['AUDIO'] as String?,
      reference: json['REFERENCE'] as String? ?? '',
      description: json['DESCRIPTION'] as String? ?? '',
      category: json['CATEGORY'] as String? ?? '',
    );
  }

  AzkarEntity toEntity() {
    return AzkarEntity(
      arabicText: arabicText,
      reference: reference,
      description: description,
      repeat: repeat,
      category: category,
    );
  }
}
