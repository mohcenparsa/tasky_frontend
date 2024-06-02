class AppConfig {
  static const bool isDevelopment =
      false; // Set to true for development, false for production

  static String get baseUrl {
    return isDevelopment
        ? 'http://20.20.20.252:5000/api'
        : 'https://todo.iraqsapp.com';
  }

  static const double maxWidth = 1000;
  static const imageBaseUrl = 'https://todo.iraqsapp.com/images/';
}
