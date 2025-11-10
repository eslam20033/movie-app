import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              children: [
                TabBar(
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 4),
                  labelPadding: EdgeInsets.symmetric(horizontal: 4),
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabAlignment: TabAlignment.center,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  indicator: BoxDecoration(
                    color: AppColors.yellowColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  labelColor: AppColors.blackColor,
                  unselectedLabelColor: AppColors.yellowColor,
                  tabs: [
                    _buildTab('Action'),
                    _buildTab('Adventure'),
                    _buildTab('Animation'),
                    _buildTab('Biography'),
                  ],
                ),

                SizedBox(height: 13),

                Expanded(
                  child: TabBarView(
                    children: List.generate(
                      4,
                          (index) => GridView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 20,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.65,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.filmDetails);
                            },
                            child: Stack(
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
                                    padding: EdgeInsets.symmetric(
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
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text) {
    return Tab(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.yellowColor, width: 2),
        ),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
    );
  }
}