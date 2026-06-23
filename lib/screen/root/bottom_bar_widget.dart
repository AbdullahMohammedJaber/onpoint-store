import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomBarWidget extends StatefulWidget {
  final Function(int) callBack;
  const BottomBarWidget({super.key, required this.callBack});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
       
      elevation: 3,
      child: Container(
        height: 70,
     
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = index;
                });
                widget.callBack(currentPage);
              },
              child: Column(
                children: [
                  Visibility(
                    visible: index == currentPage,
                    child: Container(
                      height: 5,
                      width: wi * 0.15,
                      decoration: BoxDecoration(
                        color: ColorManager.primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: wi * 0.18,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            icons[index],
                            colorFilter: ColorFilter.mode(
                              currentPage == index
                                  ? ColorManager.primaryColor
                                  : const Color(0xff979797),
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(height: 5),
                          DefaultText(
                            context.tr(title[index]),
                            color:
                                currentPage == index
                                    ? ColorManager.primaryColor
                                    : Color(0xff979797),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

List<String> icons = [
  "assets/icons/home.svg",
  "assets/icons/cart.svg",
  "assets/icons/user.svg",
  "assets/icons/setting.svg",
];
List<String> title = ["home", "cart", "profile", "settings"];
