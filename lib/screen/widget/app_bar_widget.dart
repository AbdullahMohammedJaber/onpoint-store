// ignore_for_file: must_be_immutable

import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/control_route.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class AppBarWidget extends StatelessWidget {
  final bool search;
  bool filter;
  final Function()? onTapFilter;
  final ValueChanged<String>? onSearch;
  final TextEditingController? controller;
  bool canBack;
  AppBarWidget({
    super.key,
    required this.search,
    this.filter = false,
    this.onTapFilter,
    this.onSearch,
    this.controller,
    this.canBack = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveController = controller ?? TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: hi * 0.075,

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (canBack)
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  )
                else
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/images/app_logo.png",
                          height: 32,
                          width: 32,
                        ),
                      ),
                      SizedBox(width: 8),
                      DefaultText(
                        context.tr('slogan'),
                        color: ColorManager.primaryColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),

                Spacer(),
                GestureDetector(
                  onTap: () {
                    ToWithTransition(
                      AppRoutes.login,
                      type: PageTransitionType.leftToRight,
                    );
                  },
                  child: Container(
                    color: Colors.transparent,

                    height: hi * 0.1,
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/user.svg"),
                        SizedBox(width: 5),
                        DefaultText(
                          context.tr('profile'),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: wi * 0.02),
              ],
            ),
          ),
        ),
        if (search)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: hi * 0.003),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: effectiveController,
                        onFieldSubmitted: onSearch,
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          filled: true,
                          hintText: context.tr('search_hint'),
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: wi * 0.05),
                              SvgPicture.asset("assets/icons/search.svg"),
                            ],
                          ),

                          suffixIcon:
                              filter
                                  ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(width: wi * 0.05),
                                      GestureDetector(
                                        onTap: onTapFilter,
                                        child: Container(
                                          width: 50,
                                          height: 45,
                                          color: Colors.transparent,
                                          child: Center(
                                            child: SvgPicture.asset(
                                              "assets/icons/filter.svg",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                  : null,
                          border: OutlineInputBorder(
                            borderRadius:
                                context.locale.languageCode == 'ar'
                                    ? BorderRadius.only(
                                      bottomRight: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    )
                                    : BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                    ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: wi * 0.25,
                      height: 48,
                      decoration: BoxDecoration(
                        color: ColorManager.primaryColor,
                        borderRadius:
                            context.locale.languageCode == 'ar'
                                ? BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                )
                                : BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () => onSearch?.call(effectiveController.text),
                          child: DefaultText(
                            context.tr('search'),
                            color: ColorManager.whiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
