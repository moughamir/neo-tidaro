class UIState {
  final String currentRoute;
  final Map<String, dynamic> routeParams;
  final bool isDarkMode;
  final String locale;
  final Map<String, bool> loadingStates;
  final Map<String, String> errorMessages;

  const UIState({
    required this.currentRoute,
    this.routeParams = const {},
    required this.isDarkMode,
    required this.locale,
    this.loadingStates = const {},
    this.errorMessages = const {},
  });

  factory UIState.initial() =>
      const UIState(currentRoute: '/', isDarkMode: false, locale: 'en');
}
