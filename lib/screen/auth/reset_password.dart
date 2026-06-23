import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/control_route.dart';
import 'package:ecommerce_one/screen/auth/widget_auth.dart';
import 'package:ecommerce_one/utils/services/button_widget.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/services/string.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ResetPasswordScreen> {
  TextEditingController new_password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 50),
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
                              horizontal: 30,
                              vertical: 20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: hi * 0.025),

                                DefaultText(
                                  'Reset Password',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: ColorManager.textGrey,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: 5),
                                DefaultText(
                                  'Enter new password',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.blackColor,
                                ),
                                SizedBox(height: 20),
                                formAuth(
                                  context,
                                  hint: "enter your new password",
                                  title: "New Password",
                                  pathIcon: "assets/icons/eye.svg",
                                  controller: new_password,
                                  textInputType: TextInputType.visiblePassword,
                                  validator: (p0) {
                                    if (new_password.text.isEmpty) {
                                      return StringApp.requiredField;
                                    } else if (new_password.text.length < 8) {
                                      return StringApp.passwordLessDigit;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                formAuth(
                                  context,
                                  hint: "enter your password",
                                  title: "Confirm Password",
                                  pathIcon: "assets/icons/eye.svg",
                                  controller: confirm_password,
                                  textInputType: TextInputType.visiblePassword,
                                  validator: (p0) {
                                    if (confirm_password.text.isEmpty) {
                                      return StringApp.requiredField;
                                    } else if (confirm_password.text.length <
                                        8) {
                                      return StringApp.passwordLessDigit;
                                    } else if (confirm_password.text !=
                                        new_password.text) {
                                      return "Please Enter Valied Password";
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: hi * 0.04),
                                ButtonWidget(
                                  title: "Confirm",
                                  onTap: () {
                                    if (_key.currentState!.validate()) {
                                      ToWithFade(
                                        AppRoutes.verificationCodeScreen,
                                      );
                                    }
                                  },
                                ),
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
