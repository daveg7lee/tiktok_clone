import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/widgets/dark_mode_configuration/dark_mode_config.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton(
      {super.key,
      required this.disabled,
      required this.onTap,
      required this.text});

  final bool disabled;
  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size5),
            color: disabled
                ? darkModeConfig.value
                    ? Colors.grey.shade700
                    : Colors.grey.shade100
                : Theme.of(context).primaryColor,
          ),
          child: AnimatedDefaultTextStyle(
            style: TextStyle(
                color: disabled ? Colors.grey.shade400 : Colors.white,
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600),
            duration: const Duration(milliseconds: 150),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
