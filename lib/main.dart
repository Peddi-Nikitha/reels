// import 'package:flutter/material.dart';
// import 'dart:async';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: InstagramReels(),
//       ),
//     );
//   }
// }

// class InstagramReels extends StatefulWidget {
//   @override
//   _InstagramReelsState createState() => _InstagramReelsState();
// }

// class _InstagramReelsState extends State<InstagramReels>
//     with SingleTickerProviderStateMixin {
//   final List<String> images = [
//     'assets/images/image2.jpg',
//     'assets/images/image1.jpg',
//     'assets/images/image3.jpg',
//   ];

//   List<int> likeCounts = List<int>.filled(3, 0);

//   bool isHeartFilled = false;
//   bool isHeartVisible = false;
//   Offset heartPosition = Offset.zero;

//   final PageController _pageController = PageController();
//   final PageController _pageControllerHorizontal = PageController();

//   int _currentPage = 0;
//   int _currentPageHorizontal = 0;

//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _onPageChanged(int page) {
//     setState(() {
//       _currentPageHorizontal = page;
//     });

//     // Reset animation controller when scrolling up or down to the initial image
//     if (page == 0) {
//       _animationController.reset();
//       _animationController.forward();
//     }
//   }

//   void _startTimer() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 10),
//     );

//     _animation = Tween<double>(
//       begin: 0,
//       end: 1.0,
//     ).animate(_animationController);

//     _animationController.forward();

//     _pageController.addListener(() {
//       setState(() {
//         _currentPageHorizontal = 0;
//       });
//       _animationController.reset();
//       _animationController.forward();
//     });

//     _pageControllerHorizontal.addListener(() {
//       setState(() {
//         _currentPageHorizontal = _pageControllerHorizontal.page!.toInt();
//       });

//       if (_pageControllerHorizontal.page!.toInt() == 0) {
//         _animationController.reset();
//         _animationController.forward();
//       }
//     });

//     _timer = Timer.periodic(Duration(seconds: 10), (timer) {
//       if (_currentPageHorizontal < images.length - 1) {
//         _currentPageHorizontal++;

//         _pageControllerHorizontal.animateToPage(
//           _currentPageHorizontal,
//           duration: Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//         );
//       } else {
//         _timer?.cancel();
//       }
//     });
//   }

//   void _handleDoubleTap() {
//     setState(() {
//       isHeartFilled = true;
//       Future.delayed(const Duration(milliseconds: 500), () {
//         setState(() {
//           isHeartFilled = false;
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double progressBarWidth =
//         MediaQuery.of(context).size.width / images.length * 0.9;

//     return PageView.builder(
//       controller: _pageController,
//       scrollDirection: Axis.vertical,
//       itemCount: images.length,
//       itemBuilder: (context, index) {
//         return Stack(
//           children: [
//             GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onDoubleTap: _handleDoubleTap,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   border: Border.all(color: Colors.grey),
//                 ),
//                 child: PageView.builder(
//                   controller: _pageControllerHorizontal,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: images.length,
//                   onPageChanged: (value) {
//                     setState(() {
//                       _currentPageHorizontal = value;
//                     });
//                   },
//                   itemBuilder: (context, index) {
//                     return Image.asset(
//                       images[index],
//                       fit: BoxFit.cover,
//                       width: MediaQuery.of(context).size.width,
//                     );
//                   },
//                 ),
//               ),
//             ),
//             if (isHeartVisible)
//               Positioned(
//                 top: heartPosition.dy - 20,
//                 left: heartPosition.dx - 20,
//                 child: const Icon(
//                   Icons.favorite,
//                   color: Colors.red,
//                   size: 40,
//                 ),
//               ),
//             const Positioned(
//               top: 35,
//               left: 30,
//               child: Row(
//                 children: [
//                   Text(
//                     "Reels",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                   Icon(
//                     Icons.keyboard_arrow_down_sharp,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 20,
//               right: 20,
//               child: IconButton(
//                 icon: const Icon(
//                   Icons.camera_alt,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {},
//               ),
//             ),
//             Positioned(
//               bottom: 50,
//               left: 50,
//               child: Row(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             color: const Color.fromARGB(174, 233, 30, 98),
//                             width: 2),
//                         borderRadius: BorderRadius.circular(50)),
//                     child: const CircleAvatar(
//                       backgroundImage:
//                           NetworkImage('https://via.placeholder.com/50'),
//                       // User profile image URL
//                       radius: 15,
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   const Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Username',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Small description',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               bottom: 40,
//               right: 10,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 44,
//                     height: 44,
//                     child: ColorFiltered(
//                       colorFilter: ColorFilter.mode(
//                         isHeartFilled ? Colors.red : Colors.white,
//                         BlendMode.srcATop,
//                       ),
//                       child: IconButton(
//                         icon: Container(
//                           width: 44,
//                           height: 44,
//                           child: isHeartFilled
//                               ? Transform.scale(
//                                   scale: 1.4,
//                                   child: Image.asset('assets/images/love.png'),
//                                 )
//                               : Image.asset('assets/images/heart.png'),
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             likeCounts[index]++;
//                             isHeartFilled = !isHeartFilled;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   Text(
//                     '${likeCounts[index]}',
//                     style: const TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.w800),
//                   ),
//                   SizedBox(height: 10),
//                   SizedBox(
//                     width: 44,
//                     height: 44,
//                     child: ColorFiltered(
//                       colorFilter: const ColorFilter.mode(
//                         Colors.white,
//                         BlendMode.srcATop,
//                       ),
//                       child: IconButton(
//                         icon: Image.asset(
//                           'assets/images/chat.png',
//                           color: Colors.white,
//                         ),
//                         onPressed: () {},
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   SizedBox(
//                     width: 44,
//                     height: 44,
//                     child: ColorFiltered(
//                       colorFilter: const ColorFilter.mode(
//                         Colors.white,
//                         BlendMode.srcATop,
//                       ),
//                       child: IconButton(
//                         icon: Image.asset(
//                           'assets/images/send.png',
//                           color: Colors.white,
//                         ),
//                         onPressed: () {},
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: ColorFiltered(
//                       colorFilter: const ColorFilter.mode(
//                         Colors.white,
//                         BlendMode.srcATop,
//                       ),
//                       child: Image.asset(
//                         'assets/images/more.png',
//                         width: 24,
//                         height: 24,
//                       ),
//                     ),
//                     color: Colors.white,
//                     iconSize: 36,
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 60,
//               left: 4,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     images.length,
//                     (index) => Container(
//                       width: progressBarWidth,
//                       height: 5,
//                       margin: EdgeInsets.symmetric(horizontal: 2),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: index < _currentPageHorizontal
//                             ? Colors.white
//                             : _currentPageHorizontal == index
//                                 ? Colors.grey
//                                 : Colors.grey,
//                       ),
//                       child: AnimatedBuilder(
//                         animation: _animationController,
//                         builder: (context, child) {
//                           return LinearProgressIndicator(
//                             value: (_currentPageHorizontal == index)
//                                 ? _animationController.value
//                                 : 0.0,
//                             backgroundColor: Colors.transparent,
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               Colors.white,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//       onPageChanged: (int page) {
//         setState(() {
//           _currentPage = page;

//           _animationController.reset();
//           _animationController.forward();
//         });
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: InstagramReels(),
      ),
    );
  }
}

class InstagramReels extends StatefulWidget {
  @override
  _InstagramReelsState createState() => _InstagramReelsState();
}

class _InstagramReelsState extends State<InstagramReels>
    with SingleTickerProviderStateMixin {
  final List<String> images = [
    'assets/images/image2.jpg',
    'assets/images/image1.jpg',
    'assets/images/image3.jpg',
  ];

  List<int> likeCounts = List<int>.filled(3, 0);

  bool isHeartFilled = false;
  bool isHeartVisible = false;
  Offset heartPosition = Offset.zero;

  final PageController _pageController = PageController();
  final PageController _pageControllerHorizontal = PageController();

  int _currentPage = 0;
  int _currentPageHorizontal = 0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPageHorizontal = page;
    });

    
    if (page == 0) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  void _startTimer() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();

    _pageController.addListener(() {
      setState(() {
        _currentPageHorizontal = 0;
      });
      _animationController.reset();
      _animationController.forward();
    });

    _pageControllerHorizontal.addListener(() {
      setState(() {
        _currentPageHorizontal = _pageControllerHorizontal.page!.toInt();
      });

      if (_pageControllerHorizontal.page!.toInt() == 0) {
        _animationController.reset();
        _animationController.forward();
      }
    });

    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (_currentPageHorizontal < images.length - 1) {
        _currentPageHorizontal++;

        _pageControllerHorizontal.animateToPage(
          _currentPageHorizontal,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel();
      }
    });
  }

  void _handleDoubleTap() {
    setState(() {
      isHeartFilled = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isHeartFilled = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double progressBarWidth =
        MediaQuery.of(context).size.width / images.length * 0.9;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapUp: (details) {
        final screenWidth = MediaQuery.of(context).size.width;
        final tapPosition = details.localPosition.dx;

        if (tapPosition > screenWidth / 2) {
          // Tap on the right side, move to the next image
          if (_currentPageHorizontal < images.length - 1) {
            _currentPageHorizontal++;
            _pageControllerHorizontal.animateToPage(
              _currentPageHorizontal,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        } else {
         
          if (_currentPageHorizontal > 0) {
            _currentPageHorizontal--;
            _pageControllerHorizontal.animateToPage(
              _currentPageHorizontal,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        }
      },
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: images.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;

            _animationController.reset();
            _animationController.forward();
          });
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onDoubleTap: _handleDoubleTap,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.grey),
                  ),
                  child: PageView.builder(
                    controller: _pageControllerHorizontal,
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    onPageChanged: (value) {
                      setState(() {
                        _currentPageHorizontal = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      );
                    },
                  ),
                ),
              ),
              if (isHeartVisible)
                Positioned(
                  top: heartPosition.dy - 20,
                  left: heartPosition.dx - 20,
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              const Positioned(
                top: 35,
                left: 30,
                child: Row(
                  children: [
                    Text(
                      "Reels",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
              Positioned(
                bottom: 50,
                left: 50,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(174, 233, 30, 98),
                              width: 2),
                          borderRadius: BorderRadius.circular(50)),
                      child: const CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://via.placeholder.com/50'),
                        // User profile image URL
                        radius: 15,
                      ),
                    ),
                    SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Small description',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 40,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          isHeartFilled ? Colors.red : Colors.white,
                          BlendMode.srcATop,
                        ),
                        child: IconButton(
                          icon: Container(
                            width: 44,
                            height: 44,
                            child: isHeartFilled
                                ? Transform.scale(
                                    scale: 1.4,
                                    child:
                                        Image.asset('assets/images/love.png'),
                                  )
                                : Image.asset('assets/images/heart.png'),
                          ),
                          onPressed: () {
                            setState(() {
                              likeCounts[index]++;
                              isHeartFilled = !isHeartFilled;
                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                      '${likeCounts[index]}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcATop,
                        ),
                        child: IconButton(
                          icon: Image.asset(
                            'assets/images/chat.png',
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcATop,
                        ),
                        child: IconButton(
                          icon: Image.asset(
                            'assets/images/send.png',
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    IconButton(
                      icon: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcATop,
                        ),
                        child: Image.asset(
                          'assets/images/more.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      color: Colors.white,
                      iconSize: 36,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 60,
                left: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (index) => Container(
                        width: progressBarWidth,
                        height: 5,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index < _currentPageHorizontal
                              ? Colors.white
                              : _currentPageHorizontal == index
                                  ? Colors.grey
                                  : Colors.grey,
                        ),
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return LinearProgressIndicator(
                              value: (_currentPageHorizontal == index)
                                  ? _animationController.value
                                  : 0.0,
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
