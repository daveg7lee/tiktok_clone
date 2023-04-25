import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication__repo.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _usersRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersRepository
          .findProfile(_authenticationRepository.user!.uid);

      if (profile != null) {
        return UserProfileModel.fromJSON(profile);
      }
    }

    return UserProfileModel.empty();
  }

  Future<void> createAccount(UserCredential credential) async {
    final form = ref.read(signUpForm);

    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      hasAvatar: false,
      bio: "undefined",
      link: "undefined",
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? form["username"],
      email: credential.user!.email ?? "anon@anon.com",
      birthday: form["birthday"] ?? "",
    );
    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _usersRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }

  Future<void> updateProfile({
    required String? bio,
    required String? link,
  }) async {
    state = AsyncValue.data(state.value!.copyWith(bio: bio, link: link));
    await _usersRepository
        .updateUser(state.value!.uid, {"bio": bio, "link": link});
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
    () => UsersViewModel());
