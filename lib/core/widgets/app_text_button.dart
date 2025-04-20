import 'package:chat_app_with_ai/core/theming/color_managers.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatefulWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle textStyle;
  final VoidCallback onPressed;

  const AppTextButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
  });

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: _focusNode,
      onPressed: widget.onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 16.0),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          widget.backgroundColor ?? ColorManagers.primaryColor,
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding ?? 20,
            vertical: widget.verticalPadding ?? 14,
          ),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(
            widget.buttonWidth ?? double.infinity,
            widget.buttonHeight ?? 50,
          ),
        ),
      ),
      child: Text(widget.buttonText, style: widget.textStyle),
    );
  }
}
