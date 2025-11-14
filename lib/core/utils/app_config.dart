class ApiConfig {
  static const String _flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'development',
  );

  static String get baseUrl {
    switch (_flavor) {
      case 'production':
        return '';
      case 'development':
      default:
        return '';
    }
  }
}
