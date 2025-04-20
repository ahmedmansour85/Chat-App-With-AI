import 'package:chat_app_with_ai/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(50.h),
        Text(
          "Chat App with AI 💬",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2E3A59),
          ),
        ),
        verticalSpace(16.h),
        Text(
          "Sign in to the chat app with AI",
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        verticalSpace(24.h),
      ],
    );
  }
}
