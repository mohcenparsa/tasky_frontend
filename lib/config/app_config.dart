/// Configuration settings for the application.
///
/// This class provides various configuration settings that can be used
/// throughout the application. The settings include environment-based URLs
/// and other constants.
library;

class AppConfig {
  /// Indicates whether the application is in development mode.
  ///
  /// Set to `true` for development mode, `false` for production.
  static const bool isDevelopment =
      false; // Set to true for development, false for production

  /// Returns the base URL for the API based on the environment.
  ///
  /// Uses a different URL for development and production environments.
  static String baseUrl = 'https://todo.iraqsapp.com';

  /// The maximum width for the application layout.
  static const double maxWidth = 1000;

  /// The URL for the image API.
  static String imageApi = '$baseUrl/images/';

  /// The URL for the authentication API.
  static String authApi = "$baseUrl/auth";

  /// The URL for the refreshTokenApi API.
  static String refreshTokenApi = "$authApi/refresh-token?";

  /// The URL for the profile API.
  static String profileApi = "$authApi/profile";

  /// The URL for the task API.
  static String taskApi = "$baseUrl/tasks";
}
