import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/features/movies/presentation/view_model/movie_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../gen/assets.gen.dart';
import '../../widgets/movie_poster_card.dart';

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
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.64,
                            ),
                        itemBuilder: (BuildContext context, int index) {
                          final movie = state.movieList[index];
                          return MoviePosterCard(
                            index: index,
                            image: movie.mediumCoverImage ?? '',
                            rating: movie.rating ?? 0,
                            featured: state.movieList,
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
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _searchController.clear();
                  context.read<MovieCubit>().clearSearch();
                },
                icon: Icon(Icons.clear, color: Colors.white),
              )
            : SizedBox(),
        onFieldSubmitted: (value) {
          context.read<MovieCubit>().getSearchOnMovies(search: value);
        },
      ),
    );
  }
}
