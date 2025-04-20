import 'package:chat_app_with_ai/core/helpers/app_regex.dart';
import 'package:chat_app_with_ai/core/helpers/spacing.dart';
import 'package:chat_app_with_ai/core/theming/color_managers.dart';
import 'package:chat_app_with_ai/core/widgets/app_text_form_field.dart';
import 'package:chat_app_with_ai/feature/auth/login/ui/login_screen.dart';
import 'package:chat_app_with_ai/feature/auth/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';

class EmailAndPassword extends StatefulWidget {
  final bool signupRequired;
  const EmailAndPassword({super.key, required this.signupRequired});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword>
    with SingleTickerProviderStateMixin {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _addressFocusNode.dispose();
    _phoneFocusNode.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (value.length < 2) {
      return 'Name should be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!AppRegex.isEmailValid(value)) {
      return 'Please enter a valid email (e.g., user@example.com)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    } else if (value.length < 5) {
      return 'Address must be at least 5 characters long';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    return null;
  }

  void _handleSignUp(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      MyUser user = MyUser.empty();
      user.email = emailController.text;
      user.full_name = nameController.text;
      user.address = addressController.text;
      user.phone = phoneController.text;
      setState(() {
        context.read<SignupBloc>().add(
          SignupRequired(user: user, password: passwordController.text),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          decoration: _buildContainerDecoration(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                verticalSpace(32.h),
                _buildAnimatedFormField(
                  controller: nameController,
                  focusNode: _nameFocusNode,
                  label: 'Name',
                  validator: _validateName,
                  icon: Icons.person,
                ),
                verticalSpace(20.h),
                _buildAnimatedFormField(
                  controller: emailController,
                  focusNode: _emailFocusNode,
                  label: 'Email',
                  validator: _validateEmail,
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                verticalSpace(20.h),
                _buildAnimatedFormField(
                  controller: passwordController,
                  focusNode: _passwordFocusNode,
                  label: 'Password',
                  validator: _validatePassword,
                  icon: Icons.lock,
                  isObscureText: true,
                ),
                verticalSpace(20.h),
                _buildAnimatedFormField(
                  controller: addressController,
                  focusNode: _addressFocusNode,
                  label: 'Address',
                  validator: _validateAddress,
                  icon: Icons.location_on,
                ),
                verticalSpace(20.h),
                _buildAnimatedFormField(
                  controller: phoneController,
                  focusNode: _phoneFocusNode,
                  label: 'Phone',
                  validator: _validatePhone,
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                verticalSpace(24.h),
                _buildButton(context),
                verticalSpace(24.h),
                _buildDivider(),
                verticalSpace(24.h),
                _buildSocialButtons(),
                verticalSpace(24.h),
                _buildSignInLink(),
              ],
            ),
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        verticalSpace(16.h),
        Text(
          'Enter your details to create an account',
          style: TextStyle(
            fontSize: 14.sp,
            color: ColorManagers.onBackgroundColor.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAnimatedFormField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String? Function(String?) validator,
    required IconData icon,
    bool isObscureText = false,
    TextInputType? keyboardType,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        final clampedValue = value.clamp(0.0, 1.0); // ✅ Clamp added
        return Transform.translate(
          offset: Offset(0, 20 * (1 - clampedValue)),
          child: Opacity(opacity: clampedValue, child: child),
        );
      },
      child: AppTextFormField(
        controller: controller,
        focusNode: focusNode,
        labelText: label,
        validator: validator,
        prefixIcon: Icon(icon, color: ColorManagers.primaryColor),
        isObscureText: isObscureText,
        keyboardType: keyboardType,
        height: 16.h,
        width: 16.w,
        suffixIcon:
            isObscureText
                ? IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: ColorManagers.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                )
                : null,
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        final clampedValue = value.clamp(0.0, 1.0); // ✅ Clamp added
        return Transform.scale(scale: clampedValue, child: child);
      },
      child:
          widget.signupRequired
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                onPressed: () => _handleSignUp(context),
                style: _buildButtonStyle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add, size: 20.w, color: Colors.white),
                    horizontalSpace(12.w),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
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

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            fontSize: 14.sp,
            color: ColorManagers.onBackgroundColor.withOpacity(0.7),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text(
            'Sign In',
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
          icon: Icons.facebook_rounded,
          color: const Color(0xFF1877F2),
          onPressed: () {
            // TODO: Implement Facebook sign in
          },
          tooltip: 'Sign in with Facebook',
        ),
        _buildSocialButton(
          icon: Icons.g_mobiledata_rounded,
          color: const Color(0xFFDB4437),
          onPressed: () {
            // TODO: Implement Google sign in
          },
          tooltip: 'Sign in with Google',
        ),
        _buildSocialButton(
          icon: Icons.apple_rounded,
          color: Colors.black,
          onPressed: () {
            // TODO: Implement Apple sign in
          },
          tooltip: 'Sign in with Apple',
        ),
        _buildSocialButton(
          icon: Icons.camera_alt_rounded,
          color: const Color(0xFF1DA1F2),
          onPressed: () {
            // TODO: Implement Twitter sign in
          },
          tooltip: 'Sign in with Twitter',
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: color.withOpacity(0.2), width: 1),
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(icon, color: color, size: 24.w),
              padding: EdgeInsets.all(12.w),
            ),
          ),
        ),
      ),
    );
  }
}
