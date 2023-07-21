import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    required this.text,
    required this.isPrimary,
    this.onButtonClick,
    super.key,
  });
  final String text;
  final bool isPrimary;
  final void Function()? onButtonClick;
  @override
  Widget build(BuildContext context) {
    return isPrimary
        ? ElevatedButton(
            onPressed: onButtonClick,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              text,
            ),
          )
        : OutlinedButton(
            onPressed: onButtonClick,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(text),
          );
  }
}
