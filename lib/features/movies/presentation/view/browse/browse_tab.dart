import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/features/movies/presentation/view_model/movie_cubit.dart';
import 'package:flutter_application_1/features/movies/presentation/widgets/alertdialog_no_internet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/movie_model.dart';
import '../../widgets/movie_poster_card.dart';

class BrowseTab extends StatelessWidget {
  BrowseTab({super.key});

  final List<String> genres = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'History',
    'Horror',
    'Music',
    'Musical',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Sport',
    'Thriller',
    'War',
    'Western',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieCubit()..getMovies(),
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10,
              ),
              child: Column(
                children: [
                  _buildGenreTabs(),
                  const SizedBox(height: 13),
                  Expanded(child: _buildMoviesView()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenreTabs() {
    return TabBar(
      isScrollable: true,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      tabAlignment: TabAlignment.center,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 4),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      unselectedLabelColor: AppColors.yellowColor,
      labelColor: AppColors.blackColor,
      indicator: BoxDecoration(
        color: AppColors.yellowColor,
        borderRadius: BorderRadius.circular(16),
      ),
      tabs: genres.map((g) => _buildTab(g)).toList(),
    );
  }

  Widget _buildTab(String text) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.yellowColor, width: 2),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildMoviesView() {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        if (state is MovieEmptyState) {
          return AlertDialogInternetConnection(
            text: state.message,
            onTap: () {
              context.read<MovieCubit>().getMovies();
            },
          );
        }
        if (state is MovieErrorState) {
          return _errorText("Failed to load movies");
        }
        if (state is MovieSuccessState) {
          return TabBarView(
            children: genres.map((genre) {
              final movies = _filterMoviesByGenre(state.featured, genre);
              return movies.isNotEmpty
                  ? _buildMoviesGrid(movies)
                  : _errorText("No movies found in $genre");
            }).toList(),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  List<Movies> _filterMoviesByGenre(List<Movies> movies, String genre) {
    final lower = genre.toLowerCase();
    return movies.where((m) {
      return m.genres?.any((g) => g.toLowerCase().contains(lower)) ?? false;
    }).toList();
  }

  Widget _buildMoviesGrid(List<Movies> movies) {
    return GridView.builder(
      itemCount: movies.length,
      padding: const EdgeInsets.only(top: 5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MoviePosterCard(
          image: movie.mediumCoverImage ?? '',
          rating: movie.rating ?? 0,
          featured: movies,
          index: index,
        );
      },
    );
  }

  Widget _errorText(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(color: AppColors.yellowColor, fontSize: 20),
      ),
    );
  }
}
