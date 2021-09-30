import 'package:flutter/material.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/constants.dart';
import 'home_app_bar_icon.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.pureWhite,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Row(
        children: [
          HomeAppBarIcon(
            backgroundColor: AppTheme.pureWhite,
            icon: const Icon(
              Icons.menu,
              size: 28,
            ),
            border: Border.all(
              color: Colors.black12,
            ),
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 32,
                  ),
                  Text(
                    Constants.appName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          HomeAppBarIcon(
            backgroundColor: const Color(0xFFf8be42),
            icon: const Icon(
              Icons.opacity_outlined,
              size: 28,
              color: AppTheme.pureWhite,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
