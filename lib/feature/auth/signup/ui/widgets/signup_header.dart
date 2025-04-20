import 'package:chat_app_with_ai/core/helpers/spacing.dart';
import 'package:chat_app_with_ai/core/theming/color_managers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Column(
        children: [
          Icon(
            Icons.smart_toy_outlined,
            color: ColorManagers.onBackgroundColor,
            size: 48.w,
          ),
          verticalSpace(16.h),
          Text(
            'Create Account',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: ColorManagers.onBackgroundColor,
            ),
          ),
          verticalSpace(8.h),
          Text(
            'Join our AI chat community',
            style: TextStyle(
              fontSize: 16.sp,
              color: ColorManagers.onBackgroundColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
