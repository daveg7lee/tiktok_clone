import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/views/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/views/widgets/edit_info.dart';
import 'package:tiktok_clone/features/users/views/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/views/widgets/user_info.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  void _onEditPressed() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const EditInfo(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: _onEditPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.penToSquare,
                            ),
                          ),
                          IconButton(
                            onPressed: _onGearPressed,
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
                            Gaps.v20,
                            Avatar(
                              name: data.name,
                              hasAvatar: data.hasAvatar,
                              uid: data.uid,
                            ),
                            Gaps.v20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "@${data.name}",
                                  style: const TextStyle(
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
                              height: Sizes.size56,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const UserInfo(
                                      numbers: "37", string: "Following"),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade300,
                                    indent: Sizes.size12,
                                    endIndent: Sizes.size12,
                                  ),
                                  const UserInfo(
                                      numbers: "10.5M", string: "Followers"),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade300,
                                    indent: Sizes.size12,
                                    endIndent: Sizes.size12,
                                  ),
                                  const UserInfo(
                                      numbers: "149.3M", string: "Likes"),
                                ],
                              ),
                            ),
                            Gaps.v14,
                            FractionallySizedBox(
                              widthFactor: 0.33,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size12),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(Sizes.size4),
                                  ),
                                ),
                                child: const Text(
                                  "Follow",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Gaps.v14,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size32),
                              child: Text(
                                ref.read(usersProvider).value?.bio ?? "",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.link,
                                  size: Sizes.size12,
                                ),
                                Gaps.h4,
                                Text(
                                  ref.read(usersProvider).value?.link ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v20,
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: PersistentTabBar(),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        itemCount: 20,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size2,
                          childAspectRatio: 9 / 12,
                        ),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 9 / 12,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholder:
                                        "assets/images/placeholder.jpg",
                                    image:
                                        "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                                  ),
                                ),
                                Positioned(
                                  bottom: Sizes.size2,
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.play_arrow_outlined,
                                        size: Sizes.size28,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "4.1M",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text('Page two'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
