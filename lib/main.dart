import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'api/bloc_observer.dart';
import 'api/dio_helper.dart';
import 'core/provider/app_provider.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/forget/forget_password_screen.dart';
import 'features/auth/login/login_screen.dart';
import 'features/auth/register/register_screen.dart';
import 'features/movies/data/api/dio_movie_helper.dart';
import 'features/movies/presentation/view/home/home_tab_view.dart';
import 'features/movies/presentation/view/movie_details/film_details.dart';
import 'features/movies/presentation/view/movie_details/movie_player.dart';
import 'features/movies/presentation/view/profile/editProfile_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/splash/splash_screen.dart';
import 'features/tabs/main_layout.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DioHelper.init();
  await DioMovieHelper.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return MaterialApp(
      theme: AppTheme.themeOfApp,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRoute,
      routes: {
        AppRoutes.splashRoute: (context) => const SplashScreen(),
        AppRoutes.onboardingRoute: (context) => const OnboardingScreen(),
        AppRoutes.loginRoute: (context) => const LoginScreen(),
        AppRoutes.registerRoute: (context) => const RegisterScreen(),
        AppRoutes.forgetPasswordRoute: (context) =>
            const ForgetPasswordScreen(),
        AppRoutes.homeRoute: (context) => HomeTabView(),
        AppRoutes.filmDetails: (context) => FilmDetails(),
        AppRoutes.moviePlayer: (context) => MoviePlayer(),
        AppRoutes.editProfileScreen: (context) => EditProfileScreen(),
        AppRoutes.mainLayoutRoute: (context) => MainLayout(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: appProvider.currentLocale,
    );
  }
}
