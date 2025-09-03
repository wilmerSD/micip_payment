import 'package:flutter/material.dart';

class SnackBarBottom {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(213, 88, 88, 88),
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating, // Hace que el snackbar flote
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
