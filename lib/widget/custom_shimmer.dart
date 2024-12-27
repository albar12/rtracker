import 'package:flutter/material.dart';
import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer {
  static Widget customImageShimmer(context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).unselectedWidgetColor,
              width: 0.25,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          color: AppColors.surface,
          child: Container(
            height: 100,
            padding: EdgeInsets.all(Dimensions.width20),
            child: const SizedBox(width: double.infinity),
          ),
        ),
      ),
    );
  }
}