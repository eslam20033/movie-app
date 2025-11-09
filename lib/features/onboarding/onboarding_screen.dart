import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../gen/assets.gen.dart';

class OnboardingItem {
  final String image;
  final String title;
  final String? subtitle;

  OnboardingItem({required this.image, required this.title, this.subtitle});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPageIndex = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      image: Assets.onbording.onBoarding1.path,
      title: 'Find Your Next Favorite Movie Here',
      subtitle:
          'Get access to a huge library of movies to suit all tastes. You will surely like it.',
    ),
    OnboardingItem(
      image: Assets.onbording.onBoarding2.path,
      title: 'Discover Movies',
      subtitle:
          'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
    ),
    OnboardingItem(
      image: Assets.onbording.onBoarding3.path,
      title: 'Explore All Genres',
      subtitle:
          'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
    ),
    OnboardingItem(
      image: Assets.onbording.onBoarding4.path,
      title: 'Create Watchlists',
      subtitle:
          'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
    ),
    OnboardingItem(
      image: Assets.onbording.onBoarding5.path,
      title: 'Rate, Review, and Learn',
      subtitle:
          'Share your thoughts on the movies you ve watched. Dive deep into film details and help others discover great movies with your reviews.',
    ),
    OnboardingItem(
      image: Assets.onbording.onBoarding6.path,

      title: 'Start Watching Now',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _finishOnboarding() {
    Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return buildPage(_items[index]);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(32.0, 30.0, 32.0, 30.0),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _items[_currentPageIndex].title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (_items[_currentPageIndex].subtitle != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _items[_currentPageIndex].subtitle!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                  const SizedBox(height: 30),
                  _buildNavigationControls(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(OnboardingItem item) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(item.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildNavigationControls() {
    final Color yellowColor = Colors.yellow.shade700;
    final Color darkButtonBgColor = Colors.grey.shade900;

    final filledButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: yellowColor,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );

    final backButtonStyle = OutlinedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: darkButtonBgColor,
      foregroundColor: yellowColor,
      side: BorderSide(color: yellowColor, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );

    if (_currentPageIndex == 0) {
      return ElevatedButton(
        style: filledButtonStyle,
        onPressed: _nextPage,
        child: const Text('Explore Now'),
      );
    } else if (_currentPageIndex == 1) {
      return ElevatedButton(
        style: filledButtonStyle,
        onPressed: _nextPage,
        child: const Text('Next'),
      );
    } else if (_currentPageIndex < _items.length - 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: filledButtonStyle,
            onPressed: _nextPage,
            child: const Text('Next'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            style: backButtonStyle,
            onPressed: _previousPage,
            child: const Text('Back'),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: filledButtonStyle,
            onPressed: _finishOnboarding,
            child: const Text('Finish'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            style: backButtonStyle,
            onPressed: _previousPage,
            child: const Text('Back'),
          ),
        ],
      );
    }
  }
}
