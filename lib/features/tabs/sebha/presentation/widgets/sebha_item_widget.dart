import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DarkAnimatedSebhaItem extends StatefulWidget {
  final String title;
  final String dhikr;
  final int count;
  final int target;
  final bool isCountable;
  final VoidCallback onIncrement;
  final VoidCallback onReset;

  const DarkAnimatedSebhaItem({
    super.key,
    required this.title,
    required this.dhikr,
    required this.count,
    required this.target,
    required this.isCountable,
    required this.onIncrement,
    required this.onReset,
  });

  @override
  State<DarkAnimatedSebhaItem> createState() => _DarkAnimatedSebhaItemState();
}

class _DarkAnimatedSebhaItemState extends State<DarkAnimatedSebhaItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  late ConfettiController _confettiController;
  bool _isCompleted = false;
  bool _isResetting = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation = ColorTween(
      begin: const Color(0xFF2C3E50),
      end: const Color(0xFF27AE60),
    ).animate(_animationController);

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _handleIncrement() async {
    HapticFeedback.lightImpact();
    await _animationController.forward();
    widget.onIncrement();

    if (widget.isCountable &&
        widget.target > 0 &&
        widget.count + 1 >= widget.target) {
      setState(() => _isCompleted = true);
      _confettiController.play();
      await Future.delayed(2.seconds);
      setState(() => _isCompleted = false);
    }

    await _animationController.reverse();
  }

  Future<void> _handleReset() async {
    HapticFeedback.mediumImpact();
    setState(() => _isResetting = true);
    widget.onReset();
    await Future.delayed(500.ms);
    setState(() => _isResetting = false);
  }

  @override
  Widget build(BuildContext context) {
    final double progress =
        widget.target > 0 ? widget.count / widget.target : 0;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _isCompleted
                    ? [
                        const Color(0xFF27AE60),
                        const Color(0xFF2ECC71),
                      ]
                    : [
                        const Color(0xFF2C3E50),
                        const Color(0xFF34495E),
                      ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                      .animate(
                        onComplete: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .scaleXY(
                          end: 1.05,
                          duration: 2.seconds,
                          curve: Curves.easeInOut),
                  const SizedBox(height: 8),
                  Text(
                    widget.dhikr,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF3498DB),
                    ),
                    textDirection: TextDirection.rtl,
                  )
                      .animate(
                        onComplete: (controller) => controller.repeat(),
                      )
                      .shimmer(delay: 300.ms, duration: 2.seconds),
                  const SizedBox(height: 16),
                  if (widget.isCountable) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        color: _isCompleted
                            ? Colors.white
                            : const Color(0xFF3498DB),
                        minHeight: 10,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedSwitcher(
                          duration: 300.ms,
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            '${widget.count}',
                            key: ValueKey(widget.count),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: _isCompleted
                                  ? Colors.white
                                  : const Color(0xFF3498DB),
                            ),
                          ),
                        ),
                        Text(
                          '/ ${widget.target}',
                          style: TextStyle(
                            fontSize: 18,
                            color: _isCompleted
                                ? Colors.white.withOpacity(0.8)
                                : Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _handleIncrement,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isCompleted
                                ? Colors.white
                                : const Color(0xFF3498DB),
                            foregroundColor: _isCompleted
                                ? const Color(0xFF3498DB)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            elevation: 4,
                            shadowColor:
                                const Color(0xFF3498DB).withOpacity(0.5),
                          ),
                          child: const Text('تسبيح')
                              .animate(
                                onComplete: (controller) => controller.repeat(),
                              )
                              .shakeX(delay: 1.seconds, duration: 500.ms),
                        ),
                        ElevatedButton(
                          onPressed: _handleReset,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                          ),
                          child: _isResetting
                              ? const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                )
                              : const Text('إعادة'),
                        ),
                      ],
                    ),
                  ] else ...[
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(widget.dhikr),
                            backgroundColor: const Color(0xFF3498DB),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF3498DB).withOpacity(0.2),
                        foregroundColor: const Color(0xFF3498DB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      child: const Text('ذكر')
                          .animate(
                            onComplete: (controller) => controller.repeat(),
                          )
                          .scaleXY(end: 1.05, duration: 1.seconds),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [
            Colors.white,
            Color(0xFF3498DB),
            Color(0xFF2ECC71),
            Color(0xFFF1C40F),
            Color(0xFFE74C3C),
          ],
          gravity: 0.1,
        ),
      ],
    );
  }
}
