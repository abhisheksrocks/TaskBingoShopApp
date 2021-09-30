import '../../../../../../../core/constants/app_theme.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Material(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: const Icon(
              Icons.search_outlined,
              color: AppTheme.pureWhite,
            ),
            // child: Icon(Icons.menu),
          ),
        ),
      ),
    );
  }
}
