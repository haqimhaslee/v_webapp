import 'package:flutter/material.dart';

// --- The Letter Widget ---
class LetterContent extends StatelessWidget {
  final AnimationController openingController;

  const LetterContent({super.key, required this.openingController});

  @override
  Widget build(BuildContext context) {
    // Letter animations driven by the opening controller
    final letterPositionAnimation =
        Tween<double>(begin: 0.0, end: -100.0).animate(CurvedAnimation(
      parent: openingController,
      curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
    ));

    final letterScaleAnimation =
        Tween<double>(begin: 0.2, end: 1.0).animate(CurvedAnimation(
      parent: openingController,
      curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
    ));

    final letterOpacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: openingController,
      curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
    ));

    return AnimatedBuilder(
      animation: openingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, letterPositionAnimation.value),
          child: Transform.scale(
            scale: letterScaleAnimation.value,
            child: FadeTransition(
              opacity: letterOpacityAnimation,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.9,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'To My Dearest Love,', // <<< CHANGE THIS
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia',
                          color: Color(0xFFC2185B),
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        // VVVVVV CHANGE THE MESSAGE BELOW VVVVVV
                        "Happy Birthday! 🎉\n\n"
                        "On this special day, I wanted to send you something more than just a message. I wanted to give you a little moment of magic, just like the magic you bring into my life every single day.\n\n"
                        "You are my sun, my moon, and all my stars. Every moment with you is a gift, and I cherish every memory we've made together. I can't wait to see what adventures await us in the year to come.\n\n"
                        "May your day be as beautiful and radiant as you are. I love you more than words can say.",
                        // ^^^^^^ CHANGE THE MESSAGE ABOVE ^^^^^^
                        style: TextStyle(
                          fontSize: 20,
                          height: 1.6,
                          fontFamily: 'Georgia',
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'With all my love,', // <<< CHANGE THIS
                        style: TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Georgia',
                          color: Color(0xFFC2185B),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Your Name', // <<< CHANGE YOUR NAME HERE
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia',
                          color: Color(0xFFC2185B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
