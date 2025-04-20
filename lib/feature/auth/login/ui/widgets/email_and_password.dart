import 'package:chat_app_with_ai/config/supabase_config.dart';
import 'package:chat_app_with_ai/core/helpers/app_regex.dart';
import 'package:chat_app_with_ai/core/helpers/spacing.dart';
import 'package:chat_app_with_ai/core/theming/color_managers.dart';
import 'package:chat_app_with_ai/core/widgets/app_text_form_field.dart';
import 'package:chat_app_with_ai/feature/auth/login/bloc/signin_bloc.dart';
import 'package:chat_app_with_ai/feature/auth/signup/bloc/signup_bloc.dart';
import 'package:chat_app_with_ai/feature/auth/signup/ui/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';

class EmailAndPassword extends StatefulWidget {
  final bool signinrequred;
  const EmailAndPassword({super.key, required this.signinrequred});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword>
    with SingleTickerProviderStateMixin {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    } else if (!AppRegex.isEmailValid(value)) {
      return 'Please enter a valid email address (e.g., user@example.com)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (!AppRegex.isPasswordValid(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
    }
    return null;
  }

  void _handleSignIn(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<SigninBloc>().add(
        SigninRequred(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: _buildContainerDecoration(),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildHeader(),
              ),
            ),
            verticalSpace(32.h),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildEmailField(),
              ),
            ),
            verticalSpace(20.h),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildPasswordField(),
              ),
            ),
            verticalSpace(24.h),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSignInButton(context),
              ),
            ),
            verticalSpace(24.h),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSignUpLink(),
              ),
            ),
            verticalSpace(24.h),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildDivider(),
              ),
            ),
            verticalSpace(24.h),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSocialButtons(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ColorManagers.onBackgroundColor.withOpacity(0.1),
          ColorManagers.onBackgroundColor.withOpacity(0.05),
        ],
      ),
      borderRadius: BorderRadius.circular(24.r),
      border: Border.all(
        color: ColorManagers.onBackgroundColor.withOpacity(0.1),
        width: 1,
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.smart_toy_outlined,
          color: ColorManagers.onBackgroundColor,
          size: 28.w,
        ),
        horizontalSpace(12.w),
        Text(
          'Welcome to AI Chat',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: ColorManagers.onBackgroundColor,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return AppTextFormField(
      height: 20,
      width: 20,
      focusNode: _emailFocusNode,
      hintText: 'Email',
      controller: emailController,
      prefixIcon: Icon(
        Icons.email_outlined,
        color: ColorManagers.onBackgroundColor.withOpacity(0.7),
      ),
      backgroundColor: Colors.white,
      validator: _validateEmail,
    );
  }

  Widget _buildPasswordField() {
    return AppTextFormField(
      height: 20,
      width: 20,
      focusNode: _passwordFocusNode,
      hintText: 'Password',
      controller: passwordController,
      prefixIcon: Icon(
        Icons.lock_outline,
        color: ColorManagers.onBackgroundColor.withOpacity(0.7),
      ),
      isObscureText: obscurePassword,
      backgroundColor: Colors.white,
      validator: _validatePassword,
      suffixIcon: IconButton(
        icon: Icon(
          obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: ColorManagers.onBackgroundColor.withOpacity(0.7),
        ),
        onPressed: () {
          setState(() {
            obscurePassword = !obscurePassword;
          });
        },
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return widget.signinrequred
        ? const Center(child: CircularProgressIndicator())
        : ElevatedButton(
          onPressed: () => _handleSignIn(context),
          style: _buildButtonStyle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.login, size: 20.w, color: Colors.white),
              horizontalSpace(12.w),
              Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
  }

  ButtonStyle _buildButtonStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(ColorManagers.onBackgroundColor),
      elevation: WidgetStateProperty.all(0),
      minimumSize: WidgetStateProperty.all(Size(double.infinity, 56.h)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      ),
      padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 16.h)),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: 14.sp,
            color: ColorManagers.onBackgroundColor.withOpacity(0.7),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BlocProvider(
                      create:
                          (context) => SignupBloc(
                            userRepo: SupabaseUserRepo(
                              supabase: SupabaseConfig.client,
                            ),
                          ),
                      child: const SignupScreen(),
                    ),
              ),
            );
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: ColorManagers.onBackgroundColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: ColorManagers.onBackgroundColor.withOpacity(0.2),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Or continue with',
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorManagers.onBackgroundColor.withOpacity(0.7),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: ColorManagers.onBackgroundColor.withOpacity(0.2),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialButton(
          icon: Icons.facebook,
          color: const Color(0xFF1877F2),
          onPressed: () {
            // TODO: Implement Facebook sign in
          },
        ),
        _buildSocialButton(
          icon: Icons.g_mobiledata,
          color: const Color(0xFFDB4437),
          onPressed: () {
            // TODO: Implement Google sign in
          },
        ),
        _buildSocialButton(
          icon: Icons.apple,
          color: Colors.black,
          onPressed: () {
            // TODO: Implement Apple sign in
          },
        ),
        _buildSocialButton(
          icon: Icons.camera_alt,
          color: const Color(0xFF1DA1F2),
          onPressed: () {
            // TODO: Implement Twitter sign in
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 1.0, end: 1.0),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(icon, color: color, size: 24.w),
                padding: EdgeInsets.all(12.w),
              ),
            ),
          );
        },
      ),
    );
  }
}
