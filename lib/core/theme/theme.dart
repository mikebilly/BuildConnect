import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2E7D32);
  static const Color greyBackground = Color.fromARGB(131, 227, 244, 223);
  static const Color grey = Color.fromARGB(255, 126, 124, 124);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color secondary = Color(0xFFFF8F00);
  static const Color accent = Color(0xFF0277BD);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFD32F2F);
  static const Color delete = Color(0xFFD32F2F);
  static const Color text = Color(0xFF212121);
  static const Color textLight = Color(0xFF757575);
  static const Color divider = Color(0xFFEEEEEE);
  static const Color chatBackground = Color(0xFFEFEFEF); // Nền tổng thể chat
  static const Color myMessageBackground = Color.fromARGB(255, 173, 230, 130);
  static const Color otherMessageBackground = Color.fromARGB(
    255,
    226,
    221,
    221,
  );
  static const Color myMessageText = Color(0xFF000000);
  static const Color otherMessageText = Color(0xFF333333);
  static const Color timestampColor = Color(0xFF888888);

  // color for search profile
  static const Color filterPanelBorder = Color(
    0xFFE0E0E0,
  ); // Colors.grey.shade300
  static const Color filterPanelShadow = Colors.black12;
  static const Color chipBackground = Color(0xFFF5F5F5); // Colors.grey.shade100
  static const Color chipSelectedBackground = Color.fromARGB(
    255,
    207,
    235,
    210,
  ); // Custom green tint
  static const Color chipBorder = Color(0xFFE0E0E0); // Colors.grey.shade300
  static const Color iconGrey = Color(
    0xFF757575,
  ); // Colors.grey.shade600 for dropdown arrow
  static const Color clearButtonBackground = Color(
    0xFFEF5350,
  ); // Colors.red[400] or [500]
  static const Color boxBackground = Color(0xFFE0E0E0);
  static const Color boxShadow = Colors.black12;

  static const notification = Color(0xFFD32F2F);
}

class ChatTheme {
  static const EdgeInsets messagePadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8,
  );
  static const BorderRadius myMessageBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(12),
    topRight: Radius.circular(0),
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
  );
  static const BorderRadius otherMessageBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(0),
    topRight: Radius.circular(12),
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
  );

  static const TextStyle timestampStyle = TextStyle(
    fontSize: 12,
    color: AppColors.timestampColor,
  );
}

class AppTextStyles {
  static TextStyle title = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    height: 1.4,
  );

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
  static TextStyle labelTabScreen = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

class CardSearchStyle {
  static TextStyle avatar = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.4,
    color: Colors.white,
  );
  static TextStyle title = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle body = const TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.italic,
  );
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
        iconTheme: IconThemeData(color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: AppColors.primary, size: 20),
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
          borderRadius: BorderRadius.circular(
            InputDecorationConstants.borderRadiusCircular,
          ),
          borderSide: const BorderSide(color: Colors.black45), // Darker
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            InputDecorationConstants.borderRadiusCircular,
          ),
          borderSide: const BorderSide(color: Colors.black87), // Dark grey
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            InputDecorationConstants.borderRadiusCircular,
          ),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ), // Accent color
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            InputDecorationConstants.borderRadiusCircular,
          ),
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
