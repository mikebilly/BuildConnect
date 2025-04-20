import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2E7D32);
  static const Color secondary = Color(0xFFFF8F00);
  static const Color accent = Color(0xFF0277BD);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFD32F2F);
  static const Color text = Color(0xFF212121);
  static const Color textLight = Color(0xFF757575);
  static const Color divider = Color(0xFFEEEEEE);
}

class AppTextStyles {
  static TextStyle heading = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    height: 1.4,
  );

  static TextStyle subheading = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle body = const TextStyle(fontSize: 16, height: 1.5);

  static TextStyle caption = const TextStyle(
    fontSize: 14,
    color: Colors.grey,
    height: 1.4,
  );

  static TextStyle small = const TextStyle(fontSize: 12, height: 1.4);
}

class InputDecorationConstants {
  static double borderRadiusCircular = 4;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.primary, 
        size: 20,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 16),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[50], // Darker background than grey[50]
        labelStyle: TextStyle(
          color: AppColors.text,
        ), // Keep or darken if needed
        hintStyle: TextStyle(
          color: Colors.grey[600],
        ), // Add this for darker hint
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(InputDecorationConstants.borderRadiusCircular),
          borderSide: const BorderSide(color: Colors.black45), // Darker
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(InputDecorationConstants.borderRadiusCircular),
          borderSide: const BorderSide(color: Colors.black87), // Dark grey
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(InputDecorationConstants.borderRadiusCircular),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ), // Accent color
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(InputDecorationConstants.borderRadiusCircular),
          borderSide: BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
