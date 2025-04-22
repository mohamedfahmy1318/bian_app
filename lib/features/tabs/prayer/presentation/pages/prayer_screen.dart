import 'package:film/core/di/di.dart';
import 'package:film/features/tabs/prayer/presentation/manager/cubit/prayer_times_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedPrayerScreen extends StatelessWidget {
  AnimatedPrayerScreen({super.key});

  final PrayerTimesCubit viewModel = getIt<PrayerTimesCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('مواقيت الصلاة')
            .animate()
            .fadeIn(duration: 500.ms)
            .slideX(begin: 0.5),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A237E),
                Color(0xFF283593),
              ],
            ),
          ),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF121212),
              Color(0xFF000000),
            ],
          ),
        ),
        child: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
          builder: (context, state) {
            if (state is PrayerTimesLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Color(0xFF4CAF50),
                    )
                        .animate(
                          onPlay: (controller) => controller.repeat(),
                        )
                        .rotate(duration: 1500.ms),
                    const SizedBox(height: 20),
                    Text(
                      'جاري تحميل مواقيت الصلاة...',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    )
                        .animate(
                          onPlay: (controller) => controller.repeat(),
                        )
                        .shimmer(delay: 300.ms, duration: 1000.ms)
                  ],
                ),
              );
            } else if (state is PrayerTimesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 50, color: Colors.red)
                        .animate()
                        .shake(duration: 600.ms)
                        .then()
                        .scaleXY(end: 1.2),
                    const SizedBox(height: 16),
                    Text(
                      'حدث خطأ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => viewModel.getAllTimes(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        elevation: 4,
                        shadowColor: const Color(0xFF4CAF50).withOpacity(0.5),
                      ),
                      child: const Text('حاول مرة أخرى')
                          .animate()
                          .fadeIn(delay: 300.ms),
                    ),
                  ],
                ),
              );
            } else if (state is PrayerTimesLoaded) {
              return Column(
                children: [
                  // Animated Header
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.white)
                            .animate()
                            .shakeX(delay: 1.seconds, duration: 500.ms),
                        const SizedBox(width: 10),
                        Text(
                          _formatCurrentDate(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.2),
                      ],
                    ),
                  )
                      .animate()
                      .scaleXY(begin: 0.9, end: 1.0, curve: Curves.easeOutBack),

                  // Prayer Times List
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildAnimatedPrayerTile(
                          'الفجر',
                          Icons.nightlight,
                          state.times.data!.timings!.fajr.toString(),
                          0,
                        ),
                        _buildAnimatedPrayerTile(
                          'الظهر',
                          Icons.wb_sunny,
                          state.times.data!.timings!.dhuhr.toString(),
                          1,
                        ),
                        _buildAnimatedPrayerTile(
                          'العصر',
                          Icons.brightness_high,
                          state.times.data!.timings!.asr.toString(),
                          2,
                        ),
                        _buildAnimatedPrayerTile(
                          'المغرب',
                          Icons.brightness_medium,
                          state.times.data!.timings!.maghrib.toString(),
                          3,
                        ),
                        _buildAnimatedPrayerTile(
                          'العشاء',
                          Icons.nightlight_round,
                          state.times.data!.timings!.isha.toString(),
                          4,
                        ),
                      ]
                          .animate(interval: 100.ms)
                          .fadeIn(duration: 500.ms)
                          .slideX(begin: 0.1),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Text(
                'نأسف مواعيد الصلاة لاتتوفر الأن',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnimatedPrayerTile(
    String name,
    IconData icon,
    String time,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            _getPrayerColor(index).withOpacity(0.2),
            _getPrayerColor(index).withOpacity(0.1),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, size: 32, color: _getPrayerColor(index))
            .animate()
            .scaleXY(
              begin: 0.8,
              end: 1.0,
              duration: 500.ms,
              curve: Curves.elasticOut,
            ),
        title: Text(
          name,
          style: TextStyle(
            color: _getPrayerColor(index),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          time,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[300],
            fontWeight: FontWeight.bold,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

  Color _getPrayerColor(int index) {
    final colors = [
      const Color(0xFF3498DB), // Fajr - Blue
      const Color(0xFFF1C40F), // Dhuhr - Yellow
      const Color(0xFFE67E22), // Asr - Orange
      const Color(0xFFE74C3C), // Maghrib - Red
      const Color(0xFF9B59B6), // Isha - Purple
    ];
    return colors[index];
  }

  String _formatCurrentDate() {
    final now = DateTime.now();

    // Arabic month names
    final arabicMonths = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ];

    // Arabic weekday names starting from Sunday (index 0)
    final arabicWeekdays = [
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت'
    ];

    // Get correct weekday (DateTime.weekday returns 1 for Monday)
    final weekday = arabicWeekdays[now.weekday % 7];
    final month = arabicMonths[now.month - 1];

    return '${now.day} $month ${now.year} - $weekday';
  }
}
