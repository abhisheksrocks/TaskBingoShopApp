import 'package:bingo_shop/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_theme.dart';
import 'core/constants/constants.dart';
import 'core/debug/app_bloc_observer.dart';
import 'dependency_injection.dart';
import 'presentation/bloc/login_bloc.dart';
import 'presentation/cubit/bottom_nav/bottom_nav_cubit.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  injector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<LoginBloc>()
            ..add(
              const LoginUser(
                username: 'hello@api.com',
                password: 'NotsoSecure1#',
              ),
            ),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => locator<BottomNavCubit>(),
        ),
      ],
      child: MaterialApp(
        title: Constants.appName,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        // home: const HomeScreen(),
      ),
    );
  }
}
