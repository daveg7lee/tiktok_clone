import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    Key? key,
    required this.interest,
  }) : super(key: key);

  final String interest;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;

  void onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(Sizes.size12 + Sizes.size1),
        decoration: BoxDecoration(
          color: _isSelected
              ? Theme.of(context).primaryColor
              : isDarkMode(context)
                  ? Colors.grey.shade200
                  : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size32,
          ),
          border: Border.all(
            color: Colors.black.withOpacity(0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 1.5,
            ),
          ],
        ),
        child: Text(
          widget.interest,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _isSelected ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}
