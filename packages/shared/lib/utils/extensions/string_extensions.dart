/// Extension methods for String to provide additional functionality
extension StringExtensions on String {
  /// Capitalizes the first letter of the string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Converts a string to title case (capitalizes each word)
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Returns true if the string is null, empty or consists only of whitespace
  bool get isBlank => trim().isEmpty;

  /// Returns true if the string is not null, empty and doesn't consist only of whitespace
  bool get isNotBlank => !isBlank;

  /// Truncates the string to the specified length and adds an ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }
}
