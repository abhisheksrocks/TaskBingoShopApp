import 'package:flutter/material.dart';

class HomeAppBarIcon extends StatelessWidget {
  final Color backgroundColor;
  final Icon icon;
  final BoxBorder? border;

  final BorderRadius _borderRadius = BorderRadius.circular(8);

  HomeAppBarIcon({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: backgroundColor,
          // color: const Color(0xFFf8be42),
          borderRadius: _borderRadius,
          child: Container(
            // margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: border,
              borderRadius: _borderRadius,
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: _borderRadius,
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
