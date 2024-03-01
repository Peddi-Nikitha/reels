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

class _InstagramReelsState extends State<InstagramReels> {
  final List<String> images = [
    'assets/images/image2.jpg', // Replace with actual image URLs
    'assets/images/image1.jpg',
    'assets/images/image3.jpg',
  ];

  // Initialize like counts for each image to 0
  List<int> likeCounts = List<int>.filled(3, 0);

  bool isHeartFilled = false;
  bool isHeartVisible = false;
  Offset heartPosition = Offset.zero;

  // Page controller for managing the page index
  final PageController _pageController = PageController();
    final PageController _pageControllerHorizontal = PageController();


  // Current page index
  int _currentPage = 0;
  int _currentPageHorizontal = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (_currentPageHorizontal < images.length - 1) {
        _currentPageHorizontal++;
        
      } else {
        _currentPageHorizontal = 0;
      }
      _pageControllerHorizontal.animateToPage(
        _currentPageHorizontal,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
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
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: images.length,
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
                  onPageChanged: (value){
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
                top: heartPosition.dy - 20, // Adjust position as needed
                left: heartPosition.dx - 20, // Adjust position as needed
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            Positioned(
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
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Add camera functionality
                },
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
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/50'), // User profile image URL
                      radius: 15,
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username', // Replace with actual username
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Small description', // Replace with actual description
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
                                  scale: 1.4, // Adjust the scale factor as needed
                                  child: Image.asset('assets/images/love.png'),
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
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcATop,
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/chat.png',
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Add camera functionality
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcATop,
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/send.png',
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Add camera functionality
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
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
                    onPressed: () {
                      // Add functionality
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: 37,
              right: 100,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) => Container(
                      width: 50,
                      height: 3,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _currentPageHorizontal == index
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      onPageChanged: (int page) {
        setState(() {
          _currentPage = page;
        });
      },
    );
  }
}
