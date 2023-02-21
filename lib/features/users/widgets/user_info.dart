import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.numbers, required this.string});

  final String numbers, string;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          numbers,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v3,
        Text(
          string,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
