import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:academe_x/core/utils/extensions/auth_cache_manager.dart';
import 'package:academe_x/lib.dart';

import '../../features/home/presentation/widgets/post/post_detail_screen.dart';


final goRouter = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    // Get current auth status
    final bool isAuthenticated = await getIt<HiveCacheManager>().isAuthenticated();

    // Get the current location
    final location = state.matchedLocation;

    // List of public routes that don't require authentication
    final publicRoutes = ['/login', '/on_boarding', '/sign_up', '/robot_intro'];

    print('Current location: $location');
    print('Is authenticated: $isAuthenticated');

    // Don't redirect if it's a post detail route

    if (state.matchedLocation.startsWith('/post/')) {
      return null;
    }
    // If the user is not authenticated and trying to access a protected route
    if (!isAuthenticated && !publicRoutes.contains(location)) {
      print('Redirecting to login from $location');
      return '/login';
    }

    // If the user is authenticated and trying to access login
    if (isAuthenticated && location == '/login') {
      print('Redirecting to home from login');
      return '/home_screen';
    }

    // No redirect needed
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      name: 'root',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/home_screen',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) {
        // final then = state.uri.queryParameters['then'];
        return LoginScreen();
      },
    ),
    GoRoute(
      path: '/on_boarding',
      name: 'onBoarding',
      builder: (context, state) => const OnBoarding(),
    ),
    GoRoute(
      path: '/robot_intro',
      name: 'robotIntro',
      builder: (context, state) => const RobotIntroScreen(),
    ),
    GoRoute(
      path: '/sign_up',
      name: 'signUp',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '/account_creation',
      name: 'accountCreation',
      builder: (context, state) => const AccountCreationScreen(),
    ),
    GoRoute(
      path: '/account_creation_success',
      name: 'accountCreationSuccess',
      builder: (context, state) => const AccountCreationSuccessScreen(),
    ),
    GoRoute(
      path: '/verification_code',
      name: 'verificationCode',
      builder: (context, state) => const VerificationCodeScreen(),
    ),
    GoRoute(
      path: '/forgot_password',
      name: 'forgotPassword',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/create_new_password',
      name: 'createNewPassword',
      builder: (context, state) => CreateNewPasswordScreen(),
    ),
    GoRoute(
      path: '/community_screen',
      name: 'community',
      builder: (context, state) => CommunityPage(),
    ),
    GoRoute(
      path: '/privacy_policy_page',
      name: 'privacyPolicy',
      builder: (context, state) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: '/app_notification',
      name: 'appNotification',
      builder: (context, state) => const AppNotification(),
    ),
    GoRoute(
      path: '/post/:postId',
      name: 'post',
      builder: (context, state) {
        final postId = state.pathParameters['postId']!;
        return PostDetailScreen(postId: postId);
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.matchedLocation}'),
    ),
  ),
);