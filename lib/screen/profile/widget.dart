// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/core/models/user_model.dart';
import 'package:ecommerce_one/controller/profile_cubit.dart';
import 'package:ecommerce_one/controller/profile_state.dart';
import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/control_route.dart';
import 'package:ecommerce_one/utils/services/button_widget.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

Widget profileCard(BuildContext context, UserModel user) {
  return Card(
    elevation: 0.5,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          _avatar(context, user),
          SizedBox(height: hi * 0.02),
          DefaultText(user.name, fontSize: 16, fontWeight: FontWeight.w600),
          SizedBox(height: hi * 0.01),

          DefaultText(user.email, fontSize: 12, color: ColorManager.textGrey),
          SizedBox(height: hi * 0.03),
          Divider(thickness: 0.5, color: ColorManager.greyColor),

          _menuItem(
            icon: "assets/icons/cart.svg",
            title: context.tr('orders'),
            onTap: () => ToWithFade(AppRoutes.orders),
          ),
          _menuItem(
            icon: "assets/icons/plus.svg",
            title: context.tr('favorites'),
            onTap: () => ToWithFade(AppRoutes.favorites),
          ),
          _menuItemSwitch(
            icon: "assets/icons/notification_home.svg",
            title: context.tr('notifications'),
          ),

          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

Widget _menuItem({
  required String icon,
  required String title,
  Function()? onTap,
}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    leading: Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: ColorManager.primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          color: ColorManager.primaryColor,
          width: 18,
        ),
      ),
    ),
    title: DefaultText(title, fontSize: 14, fontWeight: FontWeight.w500),
    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    onTap: onTap,
  );
}

Widget _menuItemSwitch({required String icon, required String title}) {
  bool enabled = true;

  return StatefulBuilder(
    builder: (context, setState) {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: ColorManager.primaryColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              color: ColorManager.primaryColor,
              width: 18,
            ),
          ),
        ),
        title: DefaultText(title, fontSize: 14, fontWeight: FontWeight.w500),
        trailing: Switch(
          value: enabled,
          onChanged: (value) => setState(() => enabled = value),
        ),
      );
    },
  );
}

class ProfileInfoCard extends StatefulWidget {
  final UserModel user;

  const ProfileInfoCard({super.key, required this.user});

  @override
  State<ProfileInfoCard> createState() => _ProfileInfoCardState();
}

class _ProfileInfoCardState extends State<ProfileInfoCard> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
  }

  @override
  void didUpdateWidget(covariant ProfileInfoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.user != widget.user) {
      _nameController.text = widget.user.name;
      _emailController.text = widget.user.email;
      _phoneController.text = widget.user.phone;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Card(
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      context.tr('profile_information'),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 36,
                      width: 90,
                      child: ButtonWidget(
                        title:
                            state.isSaving
                                ? true
                                : state.isEditing
                                ? context.tr('save')
                                : context.tr('edit'),
                        radius: 10,
                        onTap: () {
                          if (!state.isEditing) {
                            context.read<ProfileCubit>().startEditing();
                            return;
                          }
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<ProfileCubit>().saveProfile(
                              name: _nameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child:
                      state.isEditing
                          ? _editForm(context)
                          : Column(
                            key: const ValueKey('profile-view'),
                            children: [
                              _infoRow(
                                context,
                                '${context.tr('user_name')} : ',
                                widget.user.name,
                              ),
                              _infoRow(
                                context,
                                '${context.tr('email')} : ',
                                widget.user.email,
                              ),
                              _infoRow(
                                context,
                                '${context.tr('phone')} : ',
                                widget.user.phone,
                              ),
                            ],
                          ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _editForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        key: const ValueKey('profile-edit'),
        children: [
          _field(
            context,
            controller: _nameController,
            label: context.tr('user_name'),
          ),
          const SizedBox(height: 10),
          _field(
            context,
            controller: _emailController,
            label: context.tr('email'),
          ),
          const SizedBox(height: 10),
          _field(
            context,
            controller: _phoneController,
            label: context.tr('phone'),
          ),
        ],
      ),
    );
  }

  Widget _field(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator:
          (value) =>
              value == null || value.trim().isEmpty
                  ? context.tr('required_field')
                  : null,
    );
  }
}

Widget _infoRow(BuildContext context, String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DefaultText(
          title,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        DefaultText(
          value,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: ColorManager.textGrey,
        ),
      ],
    ),
  );
}

Widget _avatar(BuildContext context, UserModel user) {
  final imageProvider =
      user.avatarPath == null
          ? AssetImage(user.avatarAsset) as ImageProvider
          : FileImage(File(user.avatarPath!));

  return Stack(
    alignment: Alignment.bottomRight,
    children: [
      CircleAvatar(radius: 46, backgroundImage: imageProvider),
      InkWell(
        onTap: () => _pickProfileImage(context),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            color: ColorManager.primaryColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/camera.svg",
              width: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}

Future<void> _pickProfileImage(BuildContext context) async {
  final source = await showModalBottomSheet<ImageSource>(
    context: context,
    builder:
        (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(context.tr('choose_from_gallery')),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: Text(context.tr('take_photo')),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
            ],
          ),
        ),
  );

  if (source == null || !context.mounted) {
    return;
  }

  try {
    final image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1200,
    );
    if (image == null || !context.mounted) {
      return;
    }

    context.read<ProfileCubit>().updateProfileImage(image.path);
  } catch (_) {
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.tr('unable_to_pick_image'))));
  }
}
