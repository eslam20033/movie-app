import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/features/movies/presentation/view_model/movie_details_cubit.dart';
import 'package:flutter_application_1/features/movies/presentation/view_model/movie_suggestions_cubit.dart';
import 'package:flutter_application_1/features/movies/presentation/widgets/movie_poster_card.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/routes/app_routes.dart';

class FilmDetails extends StatefulWidget {
  const FilmDetails({super.key});

  @override
  State<FilmDetails> createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {};
    final int id = args['id'] ?? 0;
    return BlocProvider(
      create: (context) => MovieDetailsCubit()..fetchMovieDetails(id),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, size: 30, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(Assets.icon.save),
            ),
          ],
        ),
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsErrorState) {
              return Center(
                child: Text(state.error, style: TextStyle(color: Colors.white)),
              );
            } else if (state is MovieDetailsLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailsSuccessState) {
              final movieDetails = state.movieDetails;
              final List<String?> screenshots = [
                movieDetails.largeScreenshotImage1,
                movieDetails.largeScreenshotImage2,
                movieDetails.largeScreenshotImage3,
              ].where((url) => url != null && url.isNotEmpty).toList();
              List<Image> screenShots = screenshots
                  .map(
                    (url) => Image.network(
                      url!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Text(
                          'ScreenShoots not available',
                          style: TextStyle(color: AppColors.yellowColor),
                        );
                      },
                    ),
                  )
                  .toList();
              return SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (movieDetails.ytTrailerCode != null &&
                            movieDetails.ytTrailerCode!.isNotEmpty) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.moviePlayer,
                            arguments: {
                              'trailerId': movieDetails.ytTrailerCode,
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Trailer not available'),
                            ),
                          );
                        }
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Image.network(
                            movieDetails.largeCoverImage ?? '',
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  Assets.images.noPosterAvailable.path,
                                  width: double.infinity,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.6,
                                  fit: BoxFit.cover,
                                ),
                          ),
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withAlpha(130),
                              child: Center(
                                child: SvgPicture.asset(Assets.icon.play),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                movieDetails.title ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${movieDetails.year}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.redColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                if (movieDetails.ytTrailerCode != null &&
                                    movieDetails.ytTrailerCode!.isNotEmpty) {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.moviePlayer,
                                    arguments: {
                                      'trailerId': movieDetails.ytTrailerCode,
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Trailer not available'),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Watch',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            spacing: 16,
                            children: [
                              WatchDetails(
                                image: Assets.icon.heart,
                                text: '${movieDetails.likeCount}',
                              ),
                              WatchDetails(
                                image: Assets.icon.time,
                                text: '${movieDetails.runtime}',
                              ),
                              WatchDetails(
                                image: Assets.icon.star,
                                text: '${movieDetails.rating}',
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Screen Shots',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 15),
                          Column(spacing: 16, children: screenShots),
                          SizedBox(height: 15),
                          Text(
                            'Similar ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 15),
                          BlocBuilder(
                            bloc: MovieSuggestionsCubit()
                              ..getSuggestionsMovies(movieId: id),
                            builder: (context, state) {
                              if (state is MovieSuggestionsError) {
                                return Center(child: Text(state.message));
                              } else if (state is MovieSuggestionsSuccess) {
                                final suggestions = state.suggestionsMovies;
                                return GridView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: suggestions.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 8,
                                        childAspectRatio: 0.65,
                                      ),
                                  itemBuilder: (context, index) {
                                    return MoviePosterCard(
                                      image:
                                          suggestions[index].mediumCoverImage ??
                                          '',
                                      rating: suggestions[index].rating ?? 0,
                                      featured: suggestions,
                                      index: index,
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 15),
                          Column(
                            children: [
                              Text(
                                'Summary',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(height: 11),
                              Text(
                                movieDetails.descriptionIntro?.isNotEmpty ==
                                        true
                                    ? movieDetails.descriptionIntro!
                                    : 'No description available.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Cast',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 8),
                          GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: movieDetails.cast?.length ?? 0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 3.4,
                                ),
                            itemBuilder: (context, index) {
                              return CastCard(
                                cast: movieDetails.cast,
                                name: movieDetails.cast?[index].name ?? '',
                                character:
                                    movieDetails.cast?[index].characterName ??
                                    '',
                                image:
                                    movieDetails.cast?[index].urlSmallImage ??
                                    '',
                              );
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Genres',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 8),
                          GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 20),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: movieDetails.genres?.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 11,
                                  childAspectRatio: 2.9,
                                ),
                            itemBuilder: (context, index) {
                              return FilmTypes(
                                index: index,
                                genres: movieDetails.genres!,
                              );
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class FilmTypes extends StatelessWidget {
  const FilmTypes({super.key, required this.genres, required this.index});

  final int index;
  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 122,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          genres[index],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class CastCard extends StatelessWidget {
  const CastCard({
    super.key,
    required this.name,
    required this.image,
    required this.character,
    this.cast,
  });

  final String name;
  final cast;
  final String image;
  final String character;

  @override
  Widget build(BuildContext context) {
    return cast != null
        ? Container(
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: image.isNotEmpty
                      ? Image.network(
                          image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          Assets.images.noPhotoAvailable.path,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Name: ',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Character : ',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              character,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Text('No Cast Information Available');
  }
}

class WatchDetails extends StatelessWidget {
  const WatchDetails({required this.image, required this.text, super.key});

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 122,
        height: 47,
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image),
            SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
