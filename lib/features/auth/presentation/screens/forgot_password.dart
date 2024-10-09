import 'package:academe_x/core/extensions/context_extenssion.dart';
import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/widgets/app_custom_appBar_widget.dart';
import 'package:academe_x/features/auth/presentation/widgets/reset_password_type_way_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_button_widget.dart';
import '../../../../core/widgets/app_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppCustomAppBar(
          leading: const BackButton(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: context.localizations.forgotPasswordTitle,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                12.ph(),
                AppText(
                  text:
                  context.localizations.forgotPasswordSubTitle,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff94A3B8),
                  textAlign: TextAlign.start,
                ),
                30.ph(),
                ResetPasswordTypeWayWidget(
                  title: context.localizations.emailOption,
                  subtitle: '${context.localizations.emailDescription}: aklouk@mail.com',
                  icon: Icons.email_outlined,
                  isSelect: true, // Default selected
                ),
                12.ph(),
                ResetPasswordTypeWayWidget(
                  title: context.localizations.phoneOption,
                  subtitle: '${context.localizations.phoneDescription}: *****4566',
                  icon: Icons.phone,
                  isSelect: false,
                ),
                50.ph(),
                Center(
                  child: AppButton(
                    width: 327.w,
                    height: 56.h,
                    color: const Color(0xFF0077FF),
                    fontSize: 16.sp,
                    onPressed: () {
                      Navigator.pushNamed(context, '/verification_code');
                    },
                    fontWeight: FontWeight.w600,
                    text:context.localizations.confirmationButton,
                  ),
                ),
                20.ph(),
              ],
            )));
  }
}
