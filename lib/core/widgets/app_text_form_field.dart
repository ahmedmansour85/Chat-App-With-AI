import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theming/color_managers.dart';
import '../theming/styles.dart';

class AppTextFormField extends StatefulWidget {
  final FocusNode? focusNode;
  final double height;
  final double width;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final List<BoxShadow>? boxShadow;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final String? hintText;
  final bool isObscureText;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final String? labelText;
  final int? maxLines;
  final bool autoFocus;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  const AppTextFormField({
    super.key,
    this.focusNode,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.labelStyle,
    this.hintText,
    this.isObscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.labelText,
    required this.height,
    required this.width,
    this.textAlign,
    this.boxShadow,
    this.maxLines = 1,
    this.autoFocus = false,
    this.onChanged,
    this.keyboardType,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _gradientAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _gradientAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;
      if (hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.backgroundColor ??
                      ColorManagers.primaryColor.withOpacity(
                        0.1 + (0.1 * _gradientAnimation.value),
                      ),
                  widget.backgroundColor ??
                      ColorManagers.primaryColor.withOpacity(
                        0.05 + (0.05 * _gradientAnimation.value),
                      ),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow:
                  widget.boxShadow ??
                  [
                    BoxShadow(
                      color: ColorManagers.primaryColor.withOpacity(
                        0.1 + (0.1 * _gradientAnimation.value),
                      ),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  if (widget.focusNode != null) {
                    widget.focusNode!.requestFocus();
                  }
                },
                child: TextFormField(
                  key: ValueKey(widget.hintText),
                  autofocus: widget.autoFocus,
                  textAlign: widget.textAlign ?? TextAlign.start,
                  focusNode: widget.focusNode,
                  controller: widget.controller,
                  obscureText: widget.isObscureText,
                  maxLines: widget.maxLines,
                  onChanged: widget.onChanged,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    _handleFocusChange(true);
                  },
                  onFieldSubmitted: (_) {
                    _handleFocusChange(false);
                  },
                  style:
                      widget.inputTextStyle ??
                      TextStyles.font14onbackgroundRegular.copyWith(
                        color: ColorManagers.onBackgroundColor,
                      ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: widget.height,
                      vertical: widget.width,
                    ),
                    focusedBorder:
                        widget.focusedBorder ??
                        OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorManagers.primaryColor.withOpacity(0.8),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                    enabledBorder:
                        widget.enabledBorder ??
                        OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorManagers.onBackgroundColor.withOpacity(
                              0.2,
                            ),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent.withOpacity(0.8),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent.withOpacity(0.8),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintStyle:
                        widget.hintStyle ??
                        TextStyles.font14graysemiBold.copyWith(
                          color: ColorManagers.onBackgroundColor.withOpacity(
                            0.5,
                          ),
                        ),
                    labelText: widget.labelText ?? widget.hintText,
                    labelStyle:
                        widget.labelStyle ??
                        TextStyles.font14graysemiBold.copyWith(
                          color:
                              _isFocused
                                  ? ColorManagers.primaryColor
                                  : ColorManagers.primaryColor.withOpacity(0.8),
                        ),
                    suffixIcon:
                        widget.suffixIcon != null
                            ? _AnimatedSuffixIcon(child: widget.suffixIcon!)
                            : null,
                    prefixIcon: widget.prefixIcon,
                    filled: true,
                    fillColor: Colors.transparent,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  validator: widget.validator,
                  keyboardType: widget.keyboardType,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedSuffixIcon extends StatefulWidget {
  final Widget child;

  const _AnimatedSuffixIcon({required this.child});

  @override
  _AnimatedSuffixIconState createState() => _AnimatedSuffixIconState();
}

class _AnimatedSuffixIconState extends State<_AnimatedSuffixIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
      ),
    );
  }
}
