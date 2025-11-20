import 'package:flutter/material.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';

import '../../../../../../core/routes/app_routes.dart';

class MoviePosterCard extends StatelessWidget {
  final String image;
  final int index;
  final double rating;
  final bool isFeatured;
  List featured;

  MoviePosterCard({
    super.key,
    required this.image,
    required this.rating,
    this.isFeatured = true,
    required this.featured,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    double width = isFeatured ? 200 : 120;
    double height = isFeatured ? 300 : 180;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.filmDetails,
          arguments: {'id': featured[index].id},
        );
      },
      child: Container(
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
              Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset(Assets.images.noPosterAvailable.path),
              ),
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
      ),
    );
  }
}
