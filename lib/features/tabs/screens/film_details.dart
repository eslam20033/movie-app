import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';
import 'package:flutter_svg/svg.dart';

class FilmDetails extends StatefulWidget {
  const FilmDetails({super.key});
  static List<Image> images = [
    Image.asset(Assets.images.filmImage.path),
    Image.asset(Assets.images.filmImage.path),
    Image.asset(Assets.images.filmImage.path),
  ];
  @override
  State<FilmDetails> createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.filmDetailsImage.path),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                width: double.infinity,
                height: 645,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.bottomCenter,
                    end: AlignmentGeometry.topCenter,
                    colors: [
                      Color(0xff121312),
                      Color(0xff121312).withValues(alpha: 0.2),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 248),
                    SvgPicture.asset(Assets.icon.play),
                    SizedBox(height: 188),
                    Text(
                      'Doctor Strange in the Multiverse \n of Madness',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Text(
                      '2022',
                      style: TextStyle(
                        color: Color(0xffADADAD),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
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

                      onPressed: () {},
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
                      watchDetails(image: Assets.icon.heart, text: '15'),
                      watchDetails(image: Assets.icon.time, text: '90'),
                      watchDetails(image: Assets.icon.star, text: '7.7'),
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
                  Column(spacing: 16, children: FilmDetails.images),
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
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.65,
                        ),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(
                                  Assets.images.movieImage.path,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.blackColor.withValues(
                                  alpha: 0.71,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '7.7',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.star,
                                    size: 20,
                                    color: AppColors.yellowColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 15),
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
                    '''Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346''',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
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
                    itemCount: 5,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 8,
                          childAspectRatio: 3.4,
                        ),
                    itemBuilder: (context, index) {
                      return ActorCard();
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
                    itemCount: 5,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 11,
                          childAspectRatio: 2.9,
                        ),
                    itemBuilder: (context, index) {
                      return filmTypes();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class filmTypes extends StatelessWidget {
  const filmTypes({super.key});

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
          'Action',
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

class ActorCard extends StatelessWidget {
  const ActorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 92,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                Assets.images.actorImage.path,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Name: Hayley Atwell',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Character: Wanda Maximoff / The Scarlet Witch',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class watchDetails extends StatelessWidget {
  const watchDetails({required this.image, required this.text, super.key});
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
