import 'package:academe_x/core/di/dependency_injection.dart';
import 'package:academe_x/features/auth/presentation/controllers/cubits/authentication_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/home/bottom_nav_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/create_post_icons_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/create_post_icons_state.dart';
import 'package:academe_x/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async{
  await init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
          375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationCubit>(
              create: (context) => getIt<AuthenticationCubit>(), // Providing the AuthCubit
            ),
            BlocProvider<AuthActionCubit>(
              create: (context) => getIt<AuthActionCubit>(), // Providing the AuthCubit
            ),
            BlocProvider<BottomNavCubit>(
              create: (context) => getIt<BottomNavCubit>(), // Providing the AuthCubit
            ),
            BlocProvider(
              create: (context) => PickerCubit(CreatePostIconsInit()),
            )
          ],
          child: MaterialApp(
            title: 'AcademeX',
            locale: const Locale('ar'), // Set the locale to Arabic
            supportedLocales:  AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],


            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Cairo',
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
                surface: Colors.white,
              ),
            ),
            initialRoute: '/login',
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
      },
    );
  }
}
