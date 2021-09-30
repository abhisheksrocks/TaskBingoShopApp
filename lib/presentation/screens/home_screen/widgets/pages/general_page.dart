import 'package:flutter/material.dart';

class GeneralPage extends StatelessWidget {
  final String pageName;
  const GeneralPage({
    Key? key,
    required this.pageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(pageName),
    );
  }
}
