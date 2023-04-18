import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/widgets/dark_mode_configuration/dark_mode_config.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  static String routeName = "login";
  static String routeURL = "/login";

  const LoginScreen({super.key});

  void onSignUpTap(BuildContext context) {
    context.pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              const Text(
                "Log in to TikTok",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              const Opacity(
                opacity: 0.7,
                child: Text(
                  "Manage your account, check notifications, comment on videos, and more.",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v40,
              AuthButton(
                icon: const FaIcon(FontAwesomeIcons.user),
                text: "Use email & password",
                onTap: () {
                  _onEmailLoginTap(context);
                },
              ),
              Gaps.v16,
              AuthButton(
                icon: const FaIcon(FontAwesomeIcons.github),
                text: "Continue with Github",
                onTap: () =>
                    ref.read(socialAuthProvider.notifier).githubSignIn(context),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color:
            darkModeConfig.value ? Colors.grey.shade900 : Colors.grey.shade50,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size28,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.h4,
              GestureDetector(
                onTap: () => onSignUpTap(context),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
