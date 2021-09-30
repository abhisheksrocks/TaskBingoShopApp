import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../cubit/bottom_nav/bottom_nav_cubit.dart';
import 'bottom_nav_button.dart';

class HomeScreenBottomNavBar extends StatelessWidget {
  static const List<String> pageName = [
    'Home',
    'Orders',
    'Products',
    'Manage',
    'Account',
  ];

  static const List<IconData> icons = [
    Icons.home_outlined,
    Icons.shopping_bag_outlined,
    Icons.inventory_2_outlined,
    Icons.layers_outlined,
    Icons.person_outlined,
  ];
  const HomeScreenBottomNavBar({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.pureWhite,
      child: Builder(
        builder: (context) {
          List<Widget> list = [];
          for (int index = 0; index < icons.length; index++) {
            list.add(BottomNavButton(
              icon: icons[index],
              title: pageName[index],
              isSelected:
                  context.watch<BottomNavCubit>().state.index > index - 0.5 &&
                      context.watch<BottomNavCubit>().state.index < index + 0.5,
              functionToExecute: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ));
          }
          return Row(
            children: list,
          );
        },
      ),
    );
  }
}
