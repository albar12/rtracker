import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rtracker/helper/extensions.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final Widget title;
  final List<Widget>? actions;
  final double? bottomHeight;
  final List<Widget> bottomWidget;

  const StandardAppBar({
    Key? key,
    this.height,
    required this.title,
    this.actions,
    this.bottomHeight,
    this.bottomWidget = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultBottomHeight = 0;

    if (bottomHeight == null) {
      defaultBottomHeight = MediaQuery.of(context).size.height * 0.1;
    }

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.blue.lighten(98),
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.blue.lighten(98),
      foregroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 1,
      title: title,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(bottomHeight ?? defaultBottomHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bottomWidget,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
