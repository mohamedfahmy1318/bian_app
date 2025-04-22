import 'package:film/features/tabs/sebha/presentation/manager/sebha_cubit.dart';
import 'package:film/features/tabs/sebha/presentation/widgets/sebha_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DarkAnimatedSebhaScreen extends StatelessWidget {
  const DarkAnimatedSebhaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('السبحة الإلكترونية')
            .animate()
            .fadeIn(duration: 500.ms)
            .slideX(begin: 0.5),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A1A1A),
                Color(0xFF0D0D0D),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.5,
            colors: [
              Color(0xFF1E1E1E),
              Colors.black,
            ],
          ),
        ),
        child: BlocConsumer<SebhaCubit, SebhaState>(
          listener: (context, state) {
            if (state is SebhaError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red[900],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SebhaLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Color(0xFF4CAF50),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'جاري التحميل...',
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
            } else if (state is SebhaLoaded) {
              return AnimatedListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: state.sebhaList.length,
                itemBuilder: (context, index, animation) {
                  final sebha = state.sebhaList[index];
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutBack,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: DarkAnimatedSebhaItem(
                          title: sebha.title,
                          dhikr: sebha.dhikr,
                          count: sebha.count,
                          target: sebha.target,
                          isCountable: sebha.isCountable,
                          onIncrement: () => context
                              .read<SebhaCubit>()
                              .incrementCounter(sebha),
                          onReset: () =>
                              context.read<SebhaCubit>().resetCounter(sebha.id),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is SebhaError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red[400],
                    )
                        .animate()
                        .shake(duration: 600.ms)
                        .then()
                        .scaleXY(end: 1.2),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[300],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context.read<SebhaCubit>().loadSebha(),
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
                      child: const Text('إعادة المحاولة')
                          .animate()
                          .fadeIn(delay: 300.ms),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text(
                'لا توجد بيانات',
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
}

class AnimatedListView extends StatelessWidget {
  final int itemCount;
  final EdgeInsetsGeometry padding;
  final Widget Function(BuildContext, int, Animation<double>) itemBuilder;

  const AnimatedListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final animation = AnimationController(
          vsync: Scaffold.of(context),
          duration: const Duration(milliseconds: 500),
        );
        final item = itemBuilder(context, index, animation);
        animation.forward();
        return item;
      },
    );
  }
}
