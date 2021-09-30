import 'package:bingo_shop/presentation/bloc/login_bloc.dart';
import 'package:bingo_shop/presentation/screens/error_screen/error_screen.dart';
import 'package:bingo_shop/presentation/screens/home_screen/home_screen.dart';
import 'package:bingo_shop/presentation/screens/login_screen/login_screen.dart';
import 'package:bingo_shop/presentation/screens/order_screen/order_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  AppRouter._();

  static const String homeScreen = '/';

  static const String orderDetailsScreen = '/ordersDetailsScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (context) {
        if (context.watch<LoginBloc>().state is LoggedIn) {
          switch (routeSettings.name) {
            case homeScreen:
              return const HomeScreen();
            case orderDetailsScreen:
              return OrderDetailsScreen(
                  routeSettings.arguments as OrderDetailsScreenParams);
            default:
              return const ErrorScreeen();
          }
        } else {
          return LoginScreen();
        }
      },
    );
    // switch (routeSettings.name) {
    //   case homeScreen:

    //   default:
    // }
  }
}
