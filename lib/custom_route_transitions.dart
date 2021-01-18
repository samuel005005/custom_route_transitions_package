import 'package:flutter/material.dart';

enum AnimationType { normal, fadein }

class RouteTransition {
  final BuildContext context;
  final Widget child;
  final AnimationType animation;
  final Duration duration;
  final bool replacement;

  RouteTransition({
    this.replacement = false,
    @required this.context,
    @required this.child,
    this.animation = AnimationType.normal,
    this.duration = const Duration(milliseconds: 300),
  }) {
    switch (this.animation) {
      case AnimationType.normal:
        _normalTransition();
        break;
      case AnimationType.fadein:
        _fainTransition();
        break;
      default:
    }
  }
  void _normalTransition() =>
      _replacement(MaterialPageRoute(builder: (_) => this.child));

  void _fainTransition() {
    final route = PageRouteBuilder(
      pageBuilder: (_, __, ___) => this.child,
      transitionDuration: this.duration,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          child: child,
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
        );
      },
    );
    _replacement(route);
  }

  void _replacement(Route route) {
    if (this.replacement) {
      Navigator.pushReplacement(this.context, route);
    } else {
      Navigator.push(this.context, route);
    }
  }
}
