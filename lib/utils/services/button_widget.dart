// ignore_for_file: unused_field

import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';

import 'defulat_text.dart';

class ButtonWidget extends StatefulWidget {
  final dynamic title;
  final Color? colorTitle;
  final double? sizeTitle;
  final FontWeight? fontWeight;
  final Color? colorButton;
  final double? heightButton;
  final Function()? onTap;
  final double? radius;

  const ButtonWidget({
    super.key,
    this.title,
    this.colorTitle = Colors.white,
    this.sizeTitle = 14,
    this.radius = 30,
    this.heightButton = 48,
    this.onTap,
    this.fontWeight,
    this.colorButton,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _radiusAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _widthAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );

    _radiusAnimation = Tween<double>(
      begin: widget.radius ?? 30,
      end: (widget.heightButton ?? 48) / 2,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
  }

  @override
  void didUpdateWidget(ButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.title is bool && widget.title == true) {
      _controller.forward();
    } else if (oldWidget.title is bool && oldWidget.title == true) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = widget.title is bool && widget.title == true;

    return GestureDetector(
      onTap: isLoading ? null : widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            height: widget.heightButton,
            width: isLoading ? widget.heightButton : null,
            decoration: BoxDecoration(
              color: widget.colorButton ?? ColorManager.primaryColor,
              borderRadius: BorderRadius.circular(_radiusAnimation.value),
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child:
                    isLoading
                        ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            key: const ValueKey('loading'),
                            color: ColorManager.whiteColor,
                            strokeWidth: 2.5,
                            strokeCap: StrokeCap.round,
                          ),
                        )
                        : DefaultText(
                          key: const ValueKey('text'),
                          widget.title!,
                          fontSize: widget.sizeTitle,
                          fontWeight: widget.fontWeight ?? FontWeight.w600,
                          color: widget.colorTitle!,
                        ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ButtonWidgetBorder extends StatefulWidget {
  final dynamic title;
  final Color? colorTitle;
  final double? sizeTitle;
  final FontWeight? fontWeight;
  final Color? colorButton;
  final double? heightButton;
  final Function()? onTap;
  final double? radius;

  const ButtonWidgetBorder({
    super.key,
    this.title,
    this.colorTitle = Colors.white,
    this.sizeTitle = 14,
    this.radius = 30,
    this.heightButton = 48,
    this.onTap,
    this.fontWeight,
    this.colorButton,
  });

  @override
  State<ButtonWidgetBorder> createState() => _ButtonWidgetBorderState();
}

class _ButtonWidgetBorderState extends State<ButtonWidgetBorder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap!,
      child: Container(
        height: widget.heightButton,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(widget.radius!),
          border: Border.all(color: widget.colorButton!),
        ),
        child: Center(
          child:
              widget.title is bool && widget.title == true
                  ? CircularProgressIndicator(
                    color: ColorManager.whiteColor,
                    strokeCap: StrokeCap.square,
                  )
                  : DefaultText(
                    widget.title!,
                    fontSize: widget.sizeTitle,
                    fontWeight: widget.fontWeight ?? FontWeight.w600,
                    color: widget.colorTitle!,
                  ),
        ),
      ),
    );
  }
}
