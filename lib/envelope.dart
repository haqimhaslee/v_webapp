import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:v_webapp/ripple.dart';

// --- The Envelope Widget ---
class Envelope extends StatelessWidget {
  final AnimationController openingController;
  final Animation<double> rippleAnimation;
  final bool isOpen;

  const Envelope({
    super.key,
    required this.openingController,
    required this.rippleAnimation,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    // Envelope animations driven by the opening controller
    final flapAnimation =
        Tween<double>(begin: 0, end: -math.pi).animate(CurvedAnimation(
      parent: openingController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    ));

    final envelopeScaleAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      parent: openingController,
      curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
    ));

    final envelopeOpacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: openingController,
      curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
    ));

    return AnimatedBuilder(
      animation: openingController,
      builder: (context, child) {
        return FadeTransition(
          opacity: envelopeOpacityAnimation,
          child: ScaleTransition(
            scale: envelopeScaleAnimation,
            child: SizedBox(
              width: 300,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Ripple effect when closed
                  if (!isOpen)
                    CustomPaint(
                      painter: RipplePainter(
                          animation: rippleAnimation,
                          // ignore: deprecated_member_use
                          color: Colors.pink.withOpacity(0.3)),
                      child: const SizedBox(width: 300, height: 200),
                    ),

                  // Envelope Body (Back)
                  Positioned(
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8BBD0), // Light Pink
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Envelope Body (Front)
                  Positioned(
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: const Color(0xFFF48FB1), width: 100),
                          left:
                              BorderSide(color: Colors.transparent, width: 150),
                          right:
                              BorderSide(color: Colors.transparent, width: 150),
                        ),
                      ),
                    ),
                  ),

                  // Letter inside the envelope (static part)
                  Positioned(
                    top: -65,
                    child: Container(
                      width: 280,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),

                  // Envelope Top Flap (animated)
                  Positioned(
                    top: 0,
                    child: Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(flapAnimation.value),
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF06292), // Deeper Pink
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
