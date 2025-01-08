import 'package:flutter/material.dart';

class LoadingText extends StatefulWidget {
  const LoadingText({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingTextState createState() => _LoadingTextState();
}

class _LoadingTextState extends State<LoadingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 10.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_animation.value),
          child: Text(
            "loading...",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
    );
  }
}
