import 'package:flutter/material.dart';
import 'dart:async';

import '../util/my_box.dart';

class AutoSwipePageView extends StatefulWidget {
  @override
  _AutoSwipePageViewState createState() => _AutoSwipePageViewState();
}

class _AutoSwipePageViewState extends State<AutoSwipePageView> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  final List<String> imageList = [
    'assets/logo.png',
    'assets/logo.png',
    'assets/logo.png',
    'assets/logo.png',
    'assets/logo.png',
    'assets/logo.png',



  ];

  @override
  void initState() {
    super.initState();

    // Initialize the timer for auto-swiping every 3 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < imageList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Reset to the first page
      }

      // Trigger the page change
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return MyBox(imageurl: imageList[index],);
        },
      ),
    );
  }
}
