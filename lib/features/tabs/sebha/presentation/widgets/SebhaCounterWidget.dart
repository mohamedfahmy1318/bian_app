// lib/features/sebha/presentation/widgets/sebha_counter_widget.dart
import 'package:film/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SebhaCounterWidget extends StatelessWidget {
  final int count;
  final int target;
  final VoidCallback onIncrement;
  final VoidCallback onReset;

  const SebhaCounterWidget({
    super.key,
    required this.count,
    required this.target,
    required this.onIncrement,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final progress = target > 0 ? count / target : 0.0;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: AppColors.primaryColor,
              minHeight: 10,
            ),
            const SizedBox(height: 16),
            Text(
              '$count / $target',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onIncrement,
                  child: const Text('تسبيح'),
                ),
                ElevatedButton(
                  onPressed: onReset,
                  child: const Text('إعادة'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
