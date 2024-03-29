import 'package:flutter/material.dart';

enum ScaffoldScreen {
  scan,
  device,
  turnedOff,
}

enum SnackBarStatus {
  error,
  warning,
  info,
  success,
}

class CustomSnackBar {
  CustomSnackBar._();

  static final _snackBarKey = GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> getSnackBarKey() {
    return _snackBarKey;
  }

  static Color _getBackgroundColor(SnackBarStatus status) {
    Color backgroundColor = Colors.white.withOpacity(0.7);

    switch (status) {
      case SnackBarStatus.error:
        backgroundColor = Colors.redAccent;
        break;
      case SnackBarStatus.warning:
        backgroundColor = Colors.amberAccent;
        break;
      case SnackBarStatus.info:
        backgroundColor = Colors.blueAccent;
        break;
      case SnackBarStatus.success:
        backgroundColor = Colors.greenAccent;
        break;
    }

    return backgroundColor;
  }

  static Color _getForegroundColor(SnackBarStatus status) {
    Color foregroundColor = Colors.white;

    if (status == SnackBarStatus.warning || status == SnackBarStatus.success) {
      foregroundColor = Colors.black;
    }

    return foregroundColor;
  }

  static show({
    required SnackBarStatus status,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    Color backgroundColor = _getBackgroundColor(status);
    Color foregroundColor = _getForegroundColor(status);

    final SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: foregroundColor),
      ),
      backgroundColor: backgroundColor,
      action: action,
      duration: duration,
    );

    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
        getSnackBarKey();

    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
