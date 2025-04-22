import 'package:film/features/tabs/sebha/data/models/sebha_hive_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
class LocalSebhaDataSource {
  static const String _boxName = 'sebha_box';
  late Box<SebhaHiveModel> _box;

  Future<Box<SebhaHiveModel>> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<SebhaHiveModel>(_boxName);
    } else {
      _box = Hive.box<SebhaHiveModel>(_boxName);
    }
    return _box;
  }

  @override
  Future<List<SebhaHiveModel>> getAllSebha() async {
    final box = await _openBox();
    return box.values.toList();
  }

  @override
  Future<void> saveSebha(SebhaHiveModel sebha) async {
    final box = await _openBox();
    // Ensure we're updating by ID, not creating new entries
    if (box.containsKey(sebha.id)) {
      await box.put(sebha.id, sebha);
    } else {
      // This shouldn't happen if initialization was correct
      debugPrint('Warning: Saving new sebha with ID ${sebha.id}');
      await box.put(sebha.id, sebha);
    }
  }

  @override
  Future<void> resetSebha(String id) async {
    final box = await _openBox();
    final sebha = box.get(id);
    if (sebha != null) {
      await box.put(
          id,
          sebha.copyWith(
            count: 0,
            lastUpdated: DateTime.now(),
          ));
    }
  }

  @override
  Future<void> initializeDefaultSebha() async {
    final box = await _openBox();
    if (box.isEmpty) {
      // Use put with explicit IDs to ensure we can update them later
      await box.putAll({
        '1': SebhaHiveModel(
          id: '1',
          title: 'سبحان الله',
          dhikr: 'سبحان الله',
          count: 0,
          target: 33,
          lastUpdated: DateTime.now(),
          isCountable: true,
        ),
        '2': SebhaHiveModel(
          id: '2',
          title: 'الحمد لله',
          dhikr: 'الحمد لله',
          count: 0,
          target: 33,
          lastUpdated: DateTime.now(),
          isCountable: true,
        ),
        '3': SebhaHiveModel(
          id: '3',
          title: 'الله أكبر',
          dhikr: 'الله أكبر',
          count: 0,
          target: 34,
          lastUpdated: DateTime.now(),
          isCountable: true,
        ),
        '4': SebhaHiveModel(
          id: '4',
          title: 'لا إله إلا الله',
          dhikr: 'لا إله إلا الله',
          count: 0,
          target: 0,
          lastUpdated: DateTime.now(),
          isCountable: false,
        ),
        '5': SebhaHiveModel(
          id: '5',
          title: 'أستغفر الله',
          dhikr: 'أستغفر الله',
          count: 0,
          target: 0,
          lastUpdated: DateTime.now(),
          isCountable: false,
        ),
        '6': SebhaHiveModel(
          id: '6',
          title: 'سبحان الله وبحمده',
          dhikr: 'سبحان الله وبحمده',
          count: 0,
          target: 0,
          lastUpdated: DateTime.now(),
          isCountable: false,
        ),
      });
    }
  }
}
