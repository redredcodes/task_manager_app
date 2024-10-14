import 'package:flutter/material.dart';

import 'frosted_glass.dart';

void showSnackBarMessage(BuildContext context, String message, [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: isError ? Colors.redAccent : Colors.green,
      content: FrostedGlass(
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isError
              ? 'assets/images/remove.png'
              : 'assets/images/correct.png',
              height: 17,
              width: 17,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
                message
            ),
          ],
        ),
      ),
    ),
  );
}