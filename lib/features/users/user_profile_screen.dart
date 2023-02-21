import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/widgets/user_info.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('기현'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.gear,
                size: Sizes.size20,
              ),
            )
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/60314779?s=40&v=4"),
                child: Text("기현"),
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "@기현",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size16,
                    ),
                  ),
                  Gaps.h5,
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: Sizes.size14,
                    color: Colors.lightBlue.shade300,
                  ),
                ],
              ),
              Gaps.v24,
              SizedBox(
                height: Sizes.size44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const UserInfo(numbers: "37", string: "Following"),
                    VerticalDivider(
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      color: Colors.grey.shade300,
                      indent: Sizes.size12,
                      endIndent: Sizes.size12,
                    ),
                    const UserInfo(numbers: "10.5M", string: "Followers"),
                    VerticalDivider(
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      color: Colors.grey.shade300,
                      indent: Sizes.size12,
                      endIndent: Sizes.size12,
                    ),
                    const UserInfo(numbers: "149.3M", string: "Likes"),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
