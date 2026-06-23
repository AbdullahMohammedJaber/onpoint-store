import 'dart:async';

import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/control_route.dart';
import 'package:ecommerce_one/utils/services/button_widget.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/services/string.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _key = GlobalKey<FormState>();
  final focusNode = FocusNode();

  final pinInputController = TextEditingController();
  late Timer timer;
  dynamic remainingTime = 59;

  startTimer() {
    remainingTime = 59;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        setState(() {});
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 56,

      textStyle: const TextStyle(
        fontSize: 18,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.whiteColor,
        border: Border.all(color: ColorManager.border),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            reverse: true,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Form(
                    key: _key,
                    child: Center(
                      child: Card(
                        elevation: 1,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorManager.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: hi * 0.02),

                                DefaultText(
                                  'Please Check Your Email',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.blackColor,
                                ),
                                SizedBox(height: hi * 0.01),
                                DefaultText(
                                  'Enter the verification code we just sent to your',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: ColorManager.textGrey,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.visible,
                                ),
                                SizedBox(height: hi * 0.01),
                                Row(
                                  children: [
                                    DefaultText(
                                      'Email',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: ColorManager.textGrey,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.visible,
                                    ),
                                    SizedBox(width: 5),
                                    DefaultText(
                                      'test@gmail.com',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: ColorManager.primaryColor,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                                SizedBox(height: hi * 0.03),
                                Center(
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Pinput(
                                      length: 6,
                                      controller: pinInputController,
                                      focusNode: focusNode,
                                      defaultPinTheme: defaultPinTheme,
                                      validator: (value) {
                                        if (pinInputController.text.isEmpty) {
                                          return StringApp.requiredField;
                                        } else if (pinInputController
                                                .text
                                                .length <
                                            6) {
                                          return "Pin is incorrect";
                                        }
                                        return null;
                                      },
                                      hapticFeedbackType:
                                          HapticFeedbackType.lightImpact,
                                      onCompleted: (pin) {
                                        pinInputController.text = pin;
                                        setState(() {});
                                      },
                                      cursor: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 15,
                                            height: 1,
                                            color: ColorManager.whiteColor,
                                          ),
                                        ],
                                      ),
                                      focusedPinTheme: defaultPinTheme.copyWith(
                                        decoration: defaultPinTheme.decoration!
                                            .copyWith(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: ColorManager.primaryColor
                                                  .withOpacity(0.5),
                                              border: Border.all(
                                                color:
                                                    ColorManager.primaryColor,
                                              ),
                                            ),
                                      ),
                                      submittedPinTheme: defaultPinTheme
                                          .copyWith(
                                            decoration: defaultPinTheme
                                                .decoration!
                                                .copyWith(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      ColorManager.whiteColor,
                                                  border: Border.all(
                                                    color: ColorManager.border,
                                                  ),
                                                ),
                                          ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: wi, height: hi * 0.03),
                                ButtonWidget(
                                  onTap: () {
                                    if (_key.currentState!.validate()) {
                                      ToWithFade(AppRoutes.root);
                                    }
                                  },
                                  title: "Verification",
                                ),
                                SizedBox(width: wi, height: hi * 0.03),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
