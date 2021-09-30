import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_theme.dart';

class BottomNavButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final Function functionToExecute;

  const BottomNavButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.functionToExecute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: () => functionToExecute(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  // ),
                  child: Column(
                    children: [
                      Icon(
                        icon,
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Theme.of(context)
                                .primaryFontColor
                                .withOpacity(0.3),
                      ),
                      AutoSizeText(
                        title,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Theme.of(context)
                                  .primaryFontColor
                                  .withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
                Opacity(
                  opacity: isSelected ? 1 : 0,
                  child: Container(
                    height: 2,
                    width: 20,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      color: Color(0xFF5346af),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
