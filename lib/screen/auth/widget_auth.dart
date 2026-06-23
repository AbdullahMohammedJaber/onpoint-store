import 'package:ecommerce_one/controller/network_cubit.dart';
import 'package:ecommerce_one/controller/network_state.dart';
import 'package:ecommerce_one/utils/enum/enum_servicev.dart';
import 'package:ecommerce_one/utils/services/button_widget.dart';
import 'package:ecommerce_one/utils/services/custom_validation.dart';
import 'package:ecommerce_one/utils/services/defualt_text_form_faild.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget formAuth(
  BuildContext context, {
  required String title,
  required String hint,
  String? pathIcon,
  required TextEditingController controller,
  TextInputType? textInputType,
  String? Function(dynamic)? validator,
  Function? ontapIcon,
  bool? obscureText,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DefaultText(
        title,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),
      SizedBox(height: 2),
      ValidateWidget(
        validator: validator,
        child: TextFormFieldWidget(
          hintText: hint,
          isIcon: pathIcon != null ? true : false,
          pathIcon: pathIcon,
          ontapIcon: ontapIcon,
          controller: controller,
          textInputType: textInputType,
          obscureText: obscureText ?? false,
        ),
      ),
    ],
  );
}

Widget buildSocialAuth(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 40,
        width: 65,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: ColorManager.borderBlue, width: 1),
        ),
        child: Center(child: SvgPicture.asset("assets/icons/facebook_ic.svg")),
      ),
      SizedBox(width: 5),
      Container(
        height: 40,
        width: 65,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: ColorManager.borderBlue, width: 1),
        ),
        child: Center(child: SvgPicture.asset("assets/icons/google_ic.svg")),
      ),
      SizedBox(width: 5),
      Container(
        height: 40,
        width: 65,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: ColorManager.borderBlue, width: 1),
        ),
        child: Center(child: SvgPicture.asset("assets/icons/cib_apple.svg")),
      ),
    ],
  );
}

Widget buttonAuth({
  required bool loading,
  required String title,

  required Function() onTap,
}) {
  return BlocBuilder<NetworkCubit, NetworkState>(
    builder: (context, network) {
      final isConnected = network.status == NetworkStatus.connected;

      return Center(
        child: ButtonWidget(
          title:
              isConnected
                  ? loading
                      ? true
                      : title
                  : "Connecting Wifi ...",
          colorButton:
              isConnected ? ColorManager.primaryColor : ColorManager.greyColor,
          onTap: isConnected ? onTap : null,
        ),
      );
    },
  );
}
