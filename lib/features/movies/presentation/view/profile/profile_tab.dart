import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/features/movies/presentation/view/profile/cubit/profile_cubit.dart';
import 'package:flutter_application_1/features/movies/presentation/view/profile/widget/drawer_view.dart';
import 'package:flutter_application_1/features/movies/presentation/widgets/movie_poster_card.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/storage.dart';
import '../../../../../model/get_all_favorite_model.dart';
import '../../view_model/add_favorite_cubit.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff212121),
          title: const Text(
            'Profile',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        drawer: const Drawer(
          backgroundColor: Colors.black,
          child: DrawerView(),
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is GetUserSuccessState) {
                context.read<AddFavoriteCubit>().getAllFavoriteData();
              }
            },
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, profileState) {
                if (profileState is GetUserLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.yellowColor,
                    ),
                  );
                }

                if (profileState is GetUserSuccessState) {
                  final user = profileState.profile.data!;
                  final avatarId = user.avaterId ?? 1;

                  return Column(
                    children: [
                      Container(
                        color: const Color(0xff212121),
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            SizedBox(height: h * 0.03),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: AssetImage(
                                        'assets/avatar/avatar$avatarId.png',
                                      ),
                                    ),
                                    SizedBox(height: h * 0.018),
                                    SizedBox(
                                      width: w * 0.3,
                                      child: Text(
                                        user.name ?? 'User',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: w * 0.025),
                                const Column(
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Watch List',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                BlocBuilder<AddFavoriteCubit, AddFavoriteState>(
                                  builder: (context, state) {
                                    int count = 0;
                                    if (state is GetAllFavoriteSuccess) {
                                      count = state.favoriteList.length;
                                    }
                                    return Column(
                                      children: [
                                        Text(
                                          '$count',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'History',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),

                            SizedBox(height: h * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () async {
                                      final result = await Navigator.pushNamed(
                                        context,
                                        AppRoutes.editProfileScreen,
                                      );
                                      if (result == true)
                                        context.read<ProfileCubit>().getUser();
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppColors.yellowColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: const Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                FilledButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext dialogContext) {
                                        return AlertDialog(
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          scrollable: true,
                                          title: Text(
                                            'Logout',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          content: Text(
                                            'Are you sure,do you want to logout?',
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                      dialogContext,
                                                    );
                                                  },
                                                  child: Text(
                                                    'No',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await TokenManager.delete();
                                                    Navigator.pushNamedAndRemoveUntil(
                                                      context,
                                                      AppRoutes.loginRoute,
                                                      (r) => false,
                                                    );
                                                  },
                                                  child: Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.redColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Exit',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(Icons.logout, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: h * 0.025),
                            const TabBar(
                              indicatorColor: AppColors.yellowColor,
                              dividerColor: Colors.transparent,
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              unselectedLabelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              tabs: [
                                Tab(
                                  icon: Icon(
                                    Icons.menu,
                                    color: AppColors.yellowColor,
                                    size: 35,
                                  ),
                                  text: 'Watch List',
                                ),
                                Tab(
                                  icon: Icon(
                                    Icons.folder,
                                    color: AppColors.yellowColor,
                                    size: 35,
                                  ),
                                  text: 'History',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<AddFavoriteCubit, AddFavoriteState>(
                          builder: (context, state) {
                            if (state is GetAllFavoriteLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.yellowColor,
                                ),
                              );
                            }
                            final favoriteList = state is GetAllFavoriteSuccess
                                ? state.favoriteList
                                : <Data>[];
                            return TabBarView(
                              children: [
                                Center(
                                  child: Image.asset(
                                    Assets.images.pobcornImage.path,
                                    width: 124,
                                    height: 124,
                                  ),
                                ),
                                favoriteList.isEmpty
                                    ? Center(
                                        child: Image.asset(
                                          Assets.images.pobcornImage.path,
                                          width: 124,
                                          height: 124,
                                        ),
                                      )
                                    : GridView.builder(
                                        padding: const EdgeInsets.all(16),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 16,
                                              mainAxisSpacing: 16,
                                              childAspectRatio: 0.65,
                                            ),
                                        itemCount: favoriteList.length,
                                        itemBuilder: (context, index) {
                                          final movie = favoriteList[index];
                                          return MoviePosterCard(
                                            image: movie.imageURL ?? '',
                                            rating: movie.rating ?? 0.0,
                                            featured: favoriteList,
                                            index: index,
                                          );
                                        },
                                      ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
