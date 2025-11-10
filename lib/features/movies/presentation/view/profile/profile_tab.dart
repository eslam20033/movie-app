import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/features/movies/presentation/view/profile/widget/drawer_view.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff212121),
          title: Text('Profile'),
        ),
        drawer: Drawer(backgroundColor: Colors.black, child: DrawerView()),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Color(0xff212121)),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0.03*h),
                      Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: 0.32*w,
                                height: 0.14*h,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    Assets.avatar.avatar1.path,
                                  ),
                                ),
                              ),
                              SizedBox(height: 0.018*h),
                              Text(
                                'John Safwat',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 0.02*w),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 0.01*h),
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
                              SizedBox(width: 0.08*w),
                              Column(
                                children: [
                                  Text(
                                    '10',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 0.01*h),
                                  Text(
                                    'History',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 0.028*h),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 56,
                              child: FilledButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pushNamed(AppRoutes.editProfileScreen);
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.yellowColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 0.027*w),
                          SizedBox(
                            height: 56,
                            child: FilledButton(
                              onPressed: () {},
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
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.logout, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.025*h),

                      TabBar(
                        padding: EdgeInsets.zero,
                        indicatorColor: AppColors.yellowColor,

                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.tab,

                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        labelPadding: EdgeInsets.only(bottom: 10),
                        unselectedLabelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),

                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
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
                      SizedBox(height: 0),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: Image.asset(
                        Assets.images.pobcornImage.path,
                        width: 124,
                        height: 124,
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        Assets.images.pobcornImage.path,
                        width: 124,
                        height: 124,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}