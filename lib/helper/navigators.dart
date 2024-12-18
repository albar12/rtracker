import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Navigators {
  Navigators._();

  static GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  static Future<void> push(BuildContext context, Widget widget) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (materialContext) {
          return widget;
        },
      ),
    );
  }

  static void pushReplacement(BuildContext context, Widget widget) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (materialContext) {
          return widget;
        },
      ),
    );
  }

  static void pushAndRemoveAll(BuildContext context, Widget widget) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (materialContext) {
            return widget;
          },
        ),
        (route) => false,
      );
    });
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop(context);
  }

  static void popAll(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }
}
