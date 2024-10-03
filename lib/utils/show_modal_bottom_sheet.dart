import 'package:flutter/material.dart';

Future<T?> showCustomModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
}) {
  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return child;
    },
  );
}
