abstract class AsdRouter {
  // Adds a new entry to the pages stack
  Future<T?> push<T extends Object?>(String location);

  // Pops until provided route, if it already exists in stack
  void go(String location);

  // Navigates to Start screen and shows a snackbar if sessionExpired is true
  void logOutNavigation();

  //Close the current screen
  void pop<T extends Object?>([T? result]);
}
