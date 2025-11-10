import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../gen/assets.gen.dart';
import '../movies/presentation/view/browse/browse_tab.dart';
import '../movies/presentation/view/home/home_tab_view.dart';
import '../movies/presentation/view/profile/profile_tab.dart';
import '../movies/presentation/view/search/search_tab_view.dart';

class MainLayout extends StatefulWidget {
  MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeTabView(), SearchTab(), BrowseTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          margin: const EdgeInsets.only(right: 2, left: 2, bottom: 5, top: 5),
          decoration: BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              elevation: 0,
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: AppColors.greyColor,
              selectedItemColor: Colors.transparent,
              unselectedItemColor: Colors.transparent,
              iconSize: 30,
              items: [
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(Assets.icon.homeActive),
                  icon: SvgPicture.asset(Assets.icon.home),
                  label: "",
                ),

                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(Assets.icon.searchActive),
                  icon: SvgPicture.asset(Assets.icon.search),
                  label: "",
                ),

                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(Assets.icon.exploreActive),

                  icon: SvgPicture.asset(Assets.icon.explore),

                  label: "",
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(Assets.icon.profileActrive),
                  icon: SvgPicture.asset(Assets.icon.profile),
                  label: "",
                ),
              ],
            ),
          ),
        ),
      ),
      body: tabs[currentIndex],
    );
  }
}
