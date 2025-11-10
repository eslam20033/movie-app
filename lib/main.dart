import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/dio_helper.dart';
import 'package:flutter_application_1/core/provider/app_provider.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';
import 'package:flutter_application_1/core/theme/app_theme.dart';
import 'package:flutter_application_1/features/movies/presentation/view_model/movie_cubit.dart';
import 'package:flutter_application_1/features/tabs/main_layout.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'features/movies/data/api/dio_movie_helper.dart';
import 'features/movies/presentation/view/home/home_tab_view.dart';
import 'features/movies/presentation/view/movie_details/film_details.dart';
import 'features/movies/presentation/view/profile/editProfile_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DioHelper.init();
  await DioMovieHelper.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return MaterialApp(
      theme: AppTheme.themeOfApp,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.mainLayoutRoute,
      routes: {
        // AppRoutes.splashRoute: (context) => const SplashScreen(),
        // AppRoutes.onboardingRoute: (context) => const OnboardingScreen(),
        // AppRoutes.loginRoute: (context) => const LoginScreen(),
        // AppRoutes.registerRoute: (context) => const RegisterScreen(),
        // AppRoutes.forgetPasswordRoute: (context) =>
        //     const ForgetPasswordScreen(),
        AppRoutes.homeRoute: (context) => HomeTabView(),
        AppRoutes.filmDetails: (context) => FilmDetails(),
        AppRoutes.editProfileScreen: (context) => EditProfileScreen(),
        AppRoutes.mainLayoutRoute: (context) => MainLayout(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: appProvider.currentLocale,
    );
  }
}
