// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// import 'user_type_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => UserTypeScreen()),
//       );
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.asset("assets/images/tenxLogo.png"),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ten_x_app/common/colors/colors.dart';
import 'user_type_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _orangeZoomOut;
  late Animation<double> _circleZoomIn;
  late Animation<double> _circleZoomOut;
  late Animation<double> _secondImageAnimation;
  late Animation<Color?> _backgroundColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 4));

    // Second Image Animation (Reveal from Left to Right)
    _secondImageAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Orange Zoom-Out Animation
    _orangeZoomOut = Tween<double>(begin: 1.5, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.2, curve: Curves.easeOut)),
    );

    // Background Color Transition (Separate from Zoom-Out)
    _backgroundColor = ColorTween(begin: AppColors.redOrange, end: Colors.white).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.0, curve: Curves.easeOut)),
    );

    _circleZoomIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.3, 0.5, curve: Curves.easeIn)),
    );

    _circleZoomOut = Tween<double>(begin: 1.0, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 0.7, curve: Curves.easeOut)),
    );



    _controller.forward();

    //
    // Timer(Duration(seconds: 6), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => UserTypeScreen()),
    //   );
    // });
    Future.delayed(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(_fadeRoute(UserTypeScreen()));
    });
  }

// Custom fade transition
  PageRouteBuilder _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration(seconds: 6),
      barrierColor: Colors.white,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 0);
        const end = Offset(0, 0);
        const curve = Curves.fastOutSlowIn;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          // Keep the background color fixed during zoom-out animation
          backgroundColor: _backgroundColor.value,
          body: Stack(
            children: [
              Center(
                child: ScaleTransition(
                  scale: _orangeZoomOut,
                  child: Container(
                    // width: double.infinity,
                    // height: double.infinity,
                    decoration: BoxDecoration(
                     shape: BoxShape.circle,
                      color: AppColors.redOrange, // Keep the background color fixed during zoom-out
                    ),
                  ),
                ),
              ),
              Center(
                child: Visibility(
                  visible: _circleZoomOut.value > 0.2,
                  child: ScaleTransition(
                    scale: _circleZoomIn,
                    child: ScaleTransition(
                      scale: _circleZoomOut,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: AnimatedBuilder(
                  animation: _secondImageAnimation,
                  builder: (context, child) {
                    return ClipRect(
                      child: Align(
                        alignment: Alignment.centerRight,
                        widthFactor: _secondImageAnimation.value,
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset('assets/images/tenxLogo.png',height: 150, width: 150),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



// class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _orangeZoomOut;
//   late Animation<double> _circleZoomIn;
//   late Animation<double> _circleZoomOut;
//   late Animation<double> _secondImageAnimation;
//   late Animation<double> _textFadeIn;
//   late Animation<Color?> _backgroundColor;
//   late Animation<double> _logoFadeIn;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this, duration: Duration(seconds: 6));
//
//     // Second Image Animation (Reveal from Left to Right)
//     _secondImageAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
//       ),
//     );
//
//     _orangeZoomOut = Tween<double>(begin: 1.5, end: 0.0).animate(
//       CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.2, curve: Curves.easeOut)),
//     );
//
//     _backgroundColor = ColorTween(begin: AppColors.redOrange, end: Colors.white).animate(
//       CurvedAnimation(parent: _controller, curve: Interval(0.2, 0.3, curve: Curves.easeInOut)),
//     );
//
//     // _textFadeIn = Tween<double>(begin: 1.5, end:0.0).animate(
//     //     CurvedAnimation(parent: _controller, curve: Interval(0.2, 0.3, curve: Curves.easeInOut)),
//     //   );
//
//     _circleZoomIn = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Interval(0.3, 0.5, curve: Curves.easeIn)),
//     );
//
//     _circleZoomOut = Tween<double>(begin: 1.0, end: 0.1).animate(
//       CurvedAnimation(parent: _controller, curve: Interval(0.5, 0.7, curve: Curves.easeOut)),
//     );
//
//     // _logoFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
//     //   CurvedAnimation(parent: _controller, curve: Interval(0.7, 1.0, curve: Curves.linear)),
//     // );
//     _logoFadeIn = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.1), // Fade-in happens initially
//       ),
//     );
//
//     _textFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Interval(0.9, 1.0, curve: Curves.easeIn)),
//     );
//
//     _controller.forward();
//
//     Timer(Duration(seconds: 8), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => UserTypeScreen()),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Scaffold(
//           backgroundColor: _backgroundColor.value,
//           body: Stack(
//             children: [
//               Center(
//                 child: ScaleTransition(
//                   scale: _orangeZoomOut,
//                   child: Container(
//                     width: double.infinity,
//                     height: double.infinity,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.redOrange,
//                     ),
//                   ),
//                 ),
//               ),
//               Center(
//                 child: Visibility(
//                   visible: _circleZoomOut.value > 0.2,
//                   child: ScaleTransition(
//                     scale: _circleZoomIn,
//                     child: ScaleTransition(
//                       scale: _circleZoomOut,
//                       child: Container(
//                         width: 150,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Align(
//               //   alignment: Alignment.center,
//               //   child: FadeTransition(
//               //     opacity: _logoFadeIn,
//               //     child: Image.asset('assets/images/tenxLogo.png', width: 150),
//               //   ),
//               // ),
//               Center(
//                 child: AnimatedBuilder(
//                   animation: _secondImageAnimation,
//                   builder: (context, child) {
//                     return ClipRect(
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         widthFactor: _secondImageAnimation.value,
//                         child: child,
//                       ),
//                     );
//                   },
//                   child: Image.asset('assets/images/tenxLogo.png', width: 150),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }


















