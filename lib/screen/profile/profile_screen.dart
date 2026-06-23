// ignore_for_file: deprecated_member_use

import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/core/widgets/app_shimmer.dart';
import 'package:ecommerce_one/controller/profile_cubit.dart';
import 'package:ecommerce_one/controller/profile_state.dart';
import 'package:ecommerce_one/screen/profile/widget.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading || state.user == null) {
            return const _ProfileShimmer();
          }
          if (state.status == ProfileStatus.failure) {
            return Center(
              child: DefaultText(
                context.tr(state.errorMessage ?? 'unable_to_load_profile'),
                fontSize: 14,
                color: ColorManager.textGrey,
              ),
            );
          }
          final user = state.user!;
          return SingleChildScrollView(
            child: Stack(
              children: [
                _header(),
                Padding(
                  padding: EdgeInsets.only(top: hi * 0.03, left: 16, right: 16),
                  child: Column(
                    children: [
                      profileCard(context, user),
                      SizedBox(height: hi * 0.01),
                      ProfileInfoCard(user: user),
                      SizedBox(height: hi * 0.03),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _header() {
    return Container(
      height: hi * 0.1,
      width: double.infinity,
      color: ColorManager.primaryColor,
    );
  }
}

class _ProfileShimmer extends StatelessWidget {
  const _ProfileShimmer();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          ShimmerBox(width: double.infinity, height: 260),
          SizedBox(height: 12),
          ShimmerBox(width: double.infinity, height: 180),
        ],
      ),
    );
  }
}
