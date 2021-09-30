import 'package:bingo_shop/presentation/cubit/orders_page/orders_page_cubit.dart';

import '../../../core/constants/app_theme.dart';
import '../../../dependency_injection.dart';
import '../../cubit/bottom_nav/bottom_nav_cubit.dart';
import 'widgets/home_screen_bottom_nav_bar.dart';
import 'widgets/pages/general_page.dart';
import 'widgets/pages/orders_page/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTile = 0;

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: context.read<BottomNavCubit>().state.index.toInt(),
      keepPage: true,
    );
    _pageController.addListener(() {
      context
          .read<BottomNavCubit>()
          .changeIndex(newIndex: _pageController.page!);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(() {});
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<OrdersPageCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const HomeAppBar(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                children: const [
                  GeneralPage(pageName: 'Home'),
                  OrdersPage(),
                  GeneralPage(pageName: 'Products'),
                  GeneralPage(pageName: 'Manage'),
                  GeneralPage(pageName: 'Account'),
                ],
              ),
            ),
            HomeScreenBottomNavBar(
              pageController: _pageController,
            ),
          ],
        ),
      ),
    );
  }
}
