import 'package:ecommerce_one/core/data/request/auth/login_request.dart';
import 'package:ecommerce_one/controller/auth_cubit.dart';

import 'package:ecommerce_one/route/app_routes.dart';
import 'package:ecommerce_one/route/control_route.dart';
import 'package:ecommerce_one/screen/auth/widget_auth.dart';

import 'package:ecommerce_one/utils/global_function/validation.dart';

import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/services/string.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _key = GlobalKey<FormState>();
  late AuthCubit authCubit;
  @override
  void initState() {
    super.initState();
    authCubit = context.read<AuthCubit>();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    authCubit.closeAllLoading();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
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
                                color: Theme.of(context).cardColor,
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
                                    SizedBox(height: hi * 0.02),

                                    DefaultText(
                                      'Please enter your details',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: ColorManager.textGrey,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(height: 5),

                                    DefaultText(
                                      'Welcome Back',
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                    SizedBox(height: hi * 0.03),
                                    formAuth(
                                      context,
                                      hint: "enter your email",
                                      title: "Email Address",
                                      controller: email,
                                      textInputType: TextInputType.emailAddress,
                                      validator: (p0) {
                                        if (email.text.isEmpty) {
                                          return StringApp.requiredField;
                                        } else if (!isEmailValid(email.text)) {
                                          return StringApp.emailFalse;
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    formAuth(
                                      context,
                                      hint: "enter your password",
                                      title: "Password",
                                      pathIcon: "assets/icons/eye.svg",
                                      ontapIcon: () {
                                        authCubit.showUnShowPassword();
                                      },
                                      obscureText: state.obscureText,
                                      controller: password,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      validator: (p0) {
                                        if (password.text.isEmpty) {
                                          return StringApp.requiredField;
                                        } else if (password.text.length < 8) {
                                          return StringApp.passwordLessDigit;
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: hi * 0.015),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            ToWithFade(
                                              AppRoutes.resetPasswordScreen,
                                            );
                                          },
                                          child: DefaultText(
                                            'Forget Password?',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: ColorManager.textGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: hi * 0.03),

                                    buttonAuth(
                                      loading: state.loading,
                                      onTap: () {
                                        if (_key.currentState!.validate()) {
                                          authCubit.login(
                                            LoginRequestModel(
                                              email: email.text,
                                              password: password.text,
                                            ),
                                          );
                                        }
                                      },
                                      title: "Login",
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            color: ColorManager.textGrey,
                                            thickness: 0.5,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 2,
                                          ),
                                          child: DefaultText(
                                            "Or Login with",
                                            fontSize: 7,
                                            fontWeight: FontWeight.w500,
                                            color: ColorManager.greyColor,
                                          ),
                                        ),
                                        Expanded(
                                          child: Divider(
                                            color: ColorManager.textGrey,
                                            thickness: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),

                                    buildSocialAuth(context),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DefaultText(
                                          "Don’t have an account ?",
                                          fontSize: 8,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            ToWithFade(
                                              AppRoutes.createAccountScreen,
                                            );
                                          },
                                          child: DefaultText(
                                            "Sign Up",
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400,
                                            color: ColorManager.primaryColor,
                                          ),
                                        ),
                                      ],
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
      },
    );
  }
}
