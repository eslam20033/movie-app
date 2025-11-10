import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  int _currentIndex = 0;
  late PageController pageController;
  final List<Map<String, dynamic>> featuredMovies = [
    {
      'image': Assets.onbording.onBoarding2.path,
      'rating': '7.7',
      'title': '1917',
    },
    {
      'image': Assets.onbording.onBoarding3.path,
      'rating': '8.5',
      'title': 'Captain America',
    },
    {
      'image': Assets.onbording.onBoarding4.path,
      'rating': '7.2',
      'title': 'Batman',
    },
    // Add more as needed
  ];

  final List<Map<String, dynamic>> actionMovies = [
    {
      'image': Assets.onbording.onBoarding5.path,
      'rating': '7.9',
      'title': 'The Dark Knight',
    },
    {
      'image': Assets.onbording.onBoarding6.path,
      'rating': '8.1',
      'title': 'Inception',
    },
    // Add more as needed
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              featuredMovies[_currentIndex]['image'],
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.greyColor,
                    AppColors.greyColor.withAlpha(100),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      Assets.images.availableNow.path,
                      fit: BoxFit.cover,
                      height: 0.1 * h,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: h * 0.4,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: featuredMovies.length,
                      onPageChanged: (value) {
                        setState(() {
                          _currentIndex = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: _currentIndex == index
                              ? const EdgeInsets.symmetric(horizontal: 4)
                              : EdgeInsets.symmetric(
                                  vertical: 0.04 * h,
                                  horizontal: 4,
                                ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.filmDetails);
                            },
                            child: MoviePosterCard(
                              image: featuredMovies[index]['image'],
                              rating: featuredMovies[index]['rating'],
                              isFeatured: true,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Image.asset(
                      Assets.images.watchNow.path,
                      height: 0.15 * h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Action',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'See More ',
                              style: TextStyle(
                                color: AppColors.yellowColor,
                                fontSize: 18,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_outlined,
                              color: AppColors.yellowColor,
                              size: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: h * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: actionMovies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.filmDetails);
                            },
                            child: MoviePosterCard(
                              image: actionMovies[index]['image'],
                              rating: actionMovies[index]['rating'],
                              isFeatured: false,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoviePosterCard extends StatelessWidget {
  final String image;
  final String rating;
  final bool isFeatured;

  const MoviePosterCard({
    required this.image,
    required this.rating,
    this.isFeatured = true,
  });

  @override
  Widget build(BuildContext context) {
    double width = isFeatured ? 200 : 120;
    double height = isFeatured ? 300 : 180;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      rating,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
