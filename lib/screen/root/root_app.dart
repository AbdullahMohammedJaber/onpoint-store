import 'package:ecommerce_one/screen/cart/cart_screen.dart';
import 'package:ecommerce_one/screen/home/home_screen2.dart';
import 'package:ecommerce_one/screen/profile/profile_screen.dart';
import 'package:ecommerce_one/screen/root/bottom_bar_widget.dart';
import 'package:ecommerce_one/screen/setting/setting_screen.dart';
import 'package:flutter/material.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int index = 0;
  final List<Widget> screen = const [
    HomeScreen2(),
    CartScreen(),
    ProfileScreen(),
    SettingScreen(showBackButton: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: KeyedSubtree(key: ValueKey(index), child: screen[index]),
      ),
      bottomNavigationBar: BottomBarWidget(
        callBack: (p0) {
          setState(() {
            index = p0;
          });
        },
      ),
    );
  }
}
