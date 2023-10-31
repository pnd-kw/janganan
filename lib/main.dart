import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/app_bloc/app_bloc.dart';
import 'package:janganan/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:janganan/bloc/cubit/cubit/sign_in_cubit.dart';
import 'package:janganan/bloc/cubit/cubit/sign_up_cubit.dart';
import 'package:janganan/bloc/cubit/cubit/verification_cubit.dart';
import 'package:janganan/bloc/expanded_container/expanded_container_bloc.dart';
import 'package:janganan/bloc/janganan/janganan_bloc.dart';

import 'package:janganan/config/theme.dart';
import 'package:janganan/firebase_options.dart';

import 'package:janganan/repository/auth_repository.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:janganan/repository/firestore_repository.dart';
// import 'package:janganan/utils/otp_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:janganan/presentation/screens/add_vegetable_screen.dart';
import 'package:janganan/presentation/screens/fruits_screen.dart';
import 'package:janganan/presentation/screens/home_screen.dart';
import 'package:janganan/presentation/screens/auth/sign_in/sign_in_screen.dart';
import 'package:janganan/presentation/screens/onboarding_screen.dart';
import 'package:janganan/presentation/screens/order_screen.dart';
import 'package:janganan/presentation/screens/auth/sign_up/sign_up_screen.dart';
import 'package:janganan/presentation/screens/spices_screen.dart';
import 'package:janganan/presentation/screens/user_screen.dart';
import 'package:janganan/presentation/screens/vegetables_screen.dart';
import 'package:janganan/presentation/screens/verification_screen.dart';
import 'package:janganan/presentation/widgets/screen_navigation.dart';

void main() async {
  debugRepaintRainbowEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();

  final authenticationRepository = AuthenticationRepository(
    prefs: prefs,
    // otpUtil: OtpUtil(
    //     firebaseAuth: firebase_auth.FirebaseAuth.instance,
    //     firestoreRepository: FirestoreRepository()));
  );
  await authenticationRepository.user.first;

  // final verificationCubit = VerificationCubit(
  //     otpUtil: OtpUtil(
  //         firebaseAuth: firebase_auth.FirebaseAuth.instance,
  //         firestoreRepository: FirestoreRepository()));

  runApp(Janganan(
    authenticationRepository: authenticationRepository,
    // verificationCubit: verificationCubit,
  ));
}

class Janganan extends StatelessWidget {
  const Janganan({
    super.key,
    required AuthenticationRepository authenticationRepository,
    // required VerificationCubit verificationCubit,
  }) : _authenticationRepository = authenticationRepository;
  // _verificationCubit = verificationCubit;

  final AuthenticationRepository _authenticationRepository;
  // final VerificationCubit _verificationCubit;

  @override
  Widget build(BuildContext context) {
    String initialUserId = "";

    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppBloc(
                authenticationRepository: _authenticationRepository,
                initialUserId: initialUserId),
          ),
          BlocProvider(
            create: (context) => SignUpCubit(_authenticationRepository),
          ),
          BlocProvider(
            create: (context) => SignInCubit(_authenticationRepository),
          ),
          BlocProvider(
            create: (context) => VerificationCubit(_authenticationRepository),
          ),
          BlocProvider(
            create: (context) => BottomNavigationBloc(),
          ),
          BlocProvider(
            create: (context) => JangananBloc(),
          ),
          BlocProvider(
            create: (context) => ExpandedContainerBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Janganan',
          theme: theme,
          initialRoute: '/',
          routes: {
            '/': (context) {
              final isAuthenticated = context.watch<AppBloc>().state.status ==
                  AppStatus.authenticated;
              // final authenticationStatus =
              //     context.watch<AppBloc>().state.authenticationStatus;

              if (isAuthenticated) {
                return const ScreenNavigation();
              } else {
                return const OnBoardingScreen();
              }
            },
            // '/': (context) => const OnBoardingScreen(),
            '/sign-in-screen': (context) => const SignInScreen(),
            '/sign-up-screen': (context) => const SignUpScreen(),
            '/verification-screen': (context) => const VerificationScreen(),
            '/screen-navigation': (context) => const ScreenNavigation(),
            '/home-screen': (context) => const HomeScreen(),
            '/order-screen': (context) => const OrderScreen(),
            '/user-screen': (context) => const UserScreen(),
            '/vegetables-screen': (context) => const VegetablesScreen(),
            '/fruits-screen': (context) => const FruitsScreen(),
            '/spices-screen': (context) => const SpicesScreen(),
            '/add-vegetable-screen': (context) => const AddVegetableScreen(),
          },
        ),
      ),
    );
  }
}
