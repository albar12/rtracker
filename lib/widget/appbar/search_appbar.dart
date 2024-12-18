import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/extensions.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final Widget title;
  final List<Widget>? actions;
  final double? bottomHeight;
  final List<Widget> bottomWidget;
  final List<Widget> aboveSearchWidget;
  final Widget? suffix;
  final Function(String)? onChanged;
  final Function(String)? onEditingComplete;
  final TextEditingController? controller;

  const SearchAppBar({
    Key? key,
    this.height,
    required this.title,
    this.actions,
    this.bottomHeight,
    this.bottomWidget = const [],
    this.suffix,
    this.onChanged,
    this.onEditingComplete,
    this.controller,
    this.aboveSearchWidget = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultBottomHeight = 0;

    if (bottomHeight == null) {
      defaultBottomHeight = MediaQuery.of(context).size.height * 0.2;
    }

    List<Widget> bottomWidgetSearch = [];

    Widget searchWidget = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width15,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
          ),
          hintText: 'Search',
          suffixIcon: suffix,
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              32,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          filled: true,
        ),
        onEditingComplete: () {
          if (onEditingComplete != null) {
            onEditingComplete!(controller!.text);
          }
        },
        onChanged: onChanged,
      ),
    );

    bottomWidgetSearch.addAll(aboveSearchWidget);
    bottomWidgetSearch.add(searchWidget);
    bottomWidgetSearch.addAll(bottomWidget);

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.blue.lighten(98),
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.blue.lighten(98),
      foregroundColor: Theme.of(context).colorScheme.secondary,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(bottomHeight ?? defaultBottomHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bottomWidgetSearch,
        ),
      ),
      elevation: 1,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
