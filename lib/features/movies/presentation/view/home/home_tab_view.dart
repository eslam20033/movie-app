import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/features/movies/presentation/view_model/movie_cubit.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/movie_poster_card.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

int _currentIndex = 5;

class _HomeTabViewState extends State<HomeTabView> {
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
                                    index: index,
                                    featured: featured,
                                    image:
                                        featured[index].mediumCoverImage ?? '',
                                    rating: featured[index].rating ?? 0,
                                    isFeatured: true,
                                    // onTap: () {},
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
                                    index: index,
                                    featured: featured,
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

