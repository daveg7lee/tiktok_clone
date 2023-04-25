import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

import '../../../../common/widgets/dark_mode_configuration/dark_mode_config.dart';
import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';
import '../../../authentication/widgets/form_button.dart';

class EditInfo extends ConsumerStatefulWidget {
  const EditInfo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditInfoState();
}

class _EditInfoState extends ConsumerState<EditInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Map<String, String> formData = {
    "bio": ref.read(usersProvider).value?.bio == "undefined"
        ? ""
        : ref.read(usersProvider).value?.bio ?? "",
    "link": ref.read(usersProvider).value?.link == "undefined"
        ? ""
        : ref.read(usersProvider).value?.link ?? ""
  };

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        ref
            .read(usersProvider.notifier)
            .updateProfile(bio: formData["bio"], link: formData["link"]);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.35 + MediaQuery.of(context).viewInsets.bottom,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size10),
      ),
      clipBehavior: Clip.hardEdge,
      child: Scaffold(
        backgroundColor: darkModeConfig.value ? null : Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: darkModeConfig.value ? null : Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text("Edit Info"),
          actions: const [
            CloseButton(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Bio',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Plase write your bio";
                    }
                    return null;
                  },
                  initialValue: formData["bio"],
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['bio'] = newValue;
                    }
                  },
                ),
                Gaps.v16,
                TextFormField(
                  initialValue: formData["link"],
                  decoration: InputDecoration(
                    hintText: 'Link',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Plase write your link";
                    }
                    final regExp = RegExp(
                      r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_\+.~#?&\/\/=]*)",
                    );
                    if (value != null && !regExp.hasMatch(value)) {
                      return "Your link is not valid";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['link'] = newValue;
                    }
                  },
                ),
                Gaps.v28,
                FormButton(
                  text: "Edit",
                  disabled: false,
                  onTap: _onSubmitTap,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
