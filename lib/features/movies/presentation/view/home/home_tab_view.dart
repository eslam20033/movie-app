import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/features/movies/presentation/view_model/movie_cubit.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  int _currentIndex = 5;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 5,
      keepPage: true,
      viewportFraction: 0.6,
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
    return BlocProvider(
      create: (context) => MovieCubit()..getMovies(),
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieSuccessState) {
            final featured = state.featured;
            final action = state.action;
            return SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      featured[_currentIndex].smallCoverImage ?? '',
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
                              itemCount: featured.length,
                              onPageChanged: (value) {
                                setState(() {
                                  _currentIndex = value;
                                });
                              },
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: _currentIndex == index
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        )
                                      : EdgeInsets.symmetric(
                                          vertical: 0.04 * h,
                                          horizontal: 4,
                                        ),
                                  child: MoviePosterCard(
                                    image:
                                        featured[index].mediumCoverImage ?? '',
                                    rating: featured[index].rating ?? 0,
                                    isFeatured: true,
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
                                      'See More',
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: action.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: MoviePosterCard(
                                    image: action[index].mediumCoverImage ?? '',
                                    rating: action[index].rating ?? 0,
                                    isFeatured: false,
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
          } else if (state is MovieErrorState) {
            return Text(state.error);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}

class MoviePosterCard extends StatelessWidget {
  final String image;
  final double rating;
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
            Image.network(image, fit: BoxFit.cover),
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
                      '$rating',
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
