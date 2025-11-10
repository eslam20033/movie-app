import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/features/movies/presentation/view_model/movie_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../gen/assets.gen.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => MovieCubit(),
          child: BlocConsumer<MovieCubit, MovieState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is MovieInitial) {
                return Column(
                  children: [
                    _buildSearch(context),
                    Expanded(
                      child: Center(
                        child: Image.asset(Assets.images.pobcornImage.path),
                      ),
                    ),
                  ],
                );
              } else if (state is MovieLoadingState) {
                return Column(
                  children: [
                    _buildSearch(context),
                    Expanded(
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                );
              } else if (state is MovieEmptyState) {
                return Column(
                  children: [
                    _buildSearch(context),
                    Expanded(
                      child: Center(
                        child: Text(
                          state.message,
                          style: TextStyle(color: AppColors.yellowColor),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is SearchSuccessState) {
                return Column(
                  children: [
                    _buildSearch(context),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        itemCount: state.movieList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.64,
                            ),
                        itemBuilder: (BuildContext context, int index) {
                          final movie = state.movieList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes.filmDetails);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      movie.mediumCoverImage ?? "",
                                      width: 280,
                                      height: 320,
                                      fit: BoxFit.fill,
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Container(
                                        width: 58,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: AppColors.blackColor
                                              .withOpacity(0.7),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${movie.rating}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Icon(
                                              Icons.star,
                                              color: AppColors.yellowColor,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    'Something went wrong!',
                    style: TextStyle(color: AppColors.yellowColor),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextFormField(
        controller: _searchController,
        hintText: "Search For Movie",
        prefixIconWidget: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(Assets.icon.search),
        ),
        filledColor: AppColors.greyColor,
        onFieldSubmitted: (value) {
          context.read<MovieCubit>().getSearchOnMovies(search: value);
        },
      ),
    );
  }
}
