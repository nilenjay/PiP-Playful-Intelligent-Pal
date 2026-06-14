import 'package:flutter/material.dart';

class StarRewardAnimation extends StatefulWidget {
  final int count;

  const StarRewardAnimation({Key? key, required this.count}) : super(key: key);

  @override
  State<StarRewardAnimation> createState() => _StarRewardAnimationState();
}

class _StarRewardAnimationState extends State<StarRewardAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int _displayCount = 0;

  @override
  void initState() {
    super.initState();
    _displayCount = widget.count;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.5), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(StarRewardAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count > oldWidget.count) {
      _controller.forward(from: 0).then((_) {
        setState(() {
          _displayCount = widget.count;
        });
      });
    } else {
      _displayCount = widget.count;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: const Icon(
                Icons.star,
                color: Colors.amber,
                size: 28,
              ),
            );
          },
        ),
        const SizedBox(width: 8),
        Text(
          '$_displayCount',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
