/// Centralized class for managing all asset paths across the application.
/// Prevent hardcoding asset paths in UI code.
class AppAssets {
  AppAssets._(); // Private constructor to prevent instantiation

  // Base folder paths
  static const String _logoPath = 'assets/logos';
  static const String _imagePath = 'assets/images';
  static const String _iconPath = 'assets/icons';

  // Logos
  static const String appLogo = '$_logoPath/meal-manger-logo.png';
  static const String appLogoDark = '$_logoPath/meal-manger-logo.png';

  // Images
  static const String placeholder = '$_imagePath/placeholder.png';
  static const String splashBackground = '$_imagePath/splash_bg.png';

  // Icons
  static const String defaultUserAvatar = '$_iconPath/user_avatar.png';
}
