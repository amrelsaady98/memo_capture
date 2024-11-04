import 'package:flutter/material.dart';
import 'package:memo_capture/configs/theme/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.icon,
    this.errorText,
    required this.onTextChanged,
    this.isMultiLine = false,
  });
  final String label;
  final String? hint;
  final String? errorText;
  final void Function(String value) onTextChanged;
  final Widget? icon;
  final bool isMultiLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(label),
        ),
        const SizedBox(height: 4),
        TextField(
          maxLines: isMultiLine ? 5 : 1,
          onChanged: onTextChanged,
          decoration: InputDecoration(
            hintText: hint,
            error: errorText != null
                ? Text(
                    '$errorText',
                    style: const TextStyle(color: AppColors.bright_color),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            suffixIcon: icon,
            errorStyle: const TextStyle(color: AppColors.bright_color),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.dark_50_color,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.dark_color,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.bright_color,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.bright_color,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
    ;
  }
}
