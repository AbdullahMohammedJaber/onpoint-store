import 'package:ecommerce_one/core/data/request/auth/signup_request.dart';
import 'package:ecommerce_one/controller/auth_cubit.dart';
import 'package:ecommerce_one/screen/auth/widget_auth.dart';
import 'package:ecommerce_one/utils/global_function/validation.dart';
import 'package:ecommerce_one/utils/services/const.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/services/string.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<CreateAccountScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  TextEditingController phone = TextEditingController();

  final _key = GlobalKey<FormState>();
  late AuthCubit authCubit;
  @override
  void initState() {
    super.initState();
    authCubit = context.read<AuthCubit>();
    authCubit.closeAllLoading();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    cPassword.dispose();
    phone.dispose();
    authCubit.closeAllLoading();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
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
                                    DefaultText(
                                      'Create Your Account',
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
                                      hint: "enter your mobile number",
                                      title: "Mobile Number",
                                      controller: phone,
                                      textInputType: TextInputType.phone,
                                      validator: (p0) {
                                        if (phone.text.isEmpty) {
                                          return StringApp.requiredField;
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    formAuth(
                                      context,
                                      hint: "enter your password",
                                      title: "Password",
                                      obscureText: state.obscureText,
                                      ontapIcon: () {
                                        authCubit.showUnShowPassword();
                                      },
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      pathIcon: "assets/icons/eye.svg",
                                      controller: password,
                                      validator: (p0) {
                                        if (password.text.isEmpty) {
                                          return StringApp.requiredField;
                                        } else if (password.text.length < 8) {
                                          return StringApp.passwordLessDigit;
                                        } else if (!isPasswordValid(
                                          password.text,
                                        )) {
                                          return StringApp
                                              .passwordNotContainChar;
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    formAuth(
                                      context,
                                      hint: "enter your confirm password",
                                      title: "Confirm Password",
                                      obscureText: state.obscureText,
                                      ontapIcon: () {
                                        authCubit.showUnShowPassword();
                                      },
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      pathIcon: "assets/icons/eye.svg",
                                      controller: cPassword,
                                      validator: (p0) {
                                        if (cPassword.text.isEmpty) {
                                          return StringApp.requiredField;
                                        } else if (cPassword.text.length < 8) {
                                          return StringApp.passwordLessDigit;
                                        } else if (!isPasswordValid(
                                          cPassword.text,
                                        )) {
                                          return StringApp
                                              .passwordNotContainChar;
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: hi * 0.02),

                                    buttonAuth(
                                      loading: state.loading,
                                      onTap: () {
                                        if (_key.currentState!.validate()) {
                                          authCubit.signup(
                                            SignupRequestModel(
                                              email: email.text,
                                              password: password.text,
                                              cPassword: cPassword.text,
                                              mobile: phone.text,
                                              name: "",
                                            ),
                                          );
                                        }
                                      },
                                      title: "Create Account",
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DefaultText(
                                          "have an account ?",
                                          fontSize: 8,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: DefaultText(
                                            "Login",
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
