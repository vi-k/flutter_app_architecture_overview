abstract interface class Strings {
  static const String appName = 'Flutter App Architecture Overview';

  static const String welcome = 'Welcome';
  static const String user1 = 'User1';
  static const String user2 = 'User2';

  static const String homeTitle = appName;
  static const String homeDescription = 'This example demonstrates how scopes'
      ' work. Switching a user disposes all information of the previous user'
      ' (the old UserScope is disposed of and a new one is created). Logout'
      ' switches the Auth scope to login. AppScope remains available in all'
      ' cases.';
  static const String oneMoreDescription = 'All new screens have access to'
      ' scopes, thanks to the inclusion of navigators (NavigationNode widget)'
      ' in the tree.';
  static const String appSomeProperty = 'AppScope property';
  static const String userSomeProperty = 'UserScope property';
  static const String oneMoreScreen = 'One more screen';
  static const String logout = 'Logout';

  static const String concurencyDemoTitle = 'Concurency Demo';
  static const String concurencyDemoHomeDescription =
      'Concurency demo demonstrates how different patterns from under the hood'
      ' handle race condition.';
  static const String concurencyDemoDescription =
      'This example demonstrates how different patterns from under the hood'
      ' handle race condition. Requests are executed with a random duration.';
  static const String concurencyDemoInputLabel = 'Enter text very quickly';
  static const String concurencyDemoClearHistory = 'Clear history';
  static const String concurencyDemoObservableTitle = 'Observable';
  static const String concurencyDemoObservableSubtitle = '~ChangeNotifier';
  static const String concurencyDemoPublisherTitle = 'Publisher';
  static const String concurencyDemoPublisherSubtitle = '~Cubit';
  static const String concurencyDemoBlocTitle = 'BLoC';
  static const String concurencyDemoSequentialBlocSubtitle = 'sequential';
  static const String concurencyDemoRestartableBlocSubtitle = 'restartable';

  static const String lastResults = 'Last results';
  static const String lastResultsDescription =
      'This example demonstrates that the modal window is in the same scope'
      ' as the Concurency Demo screen, thanks to the inclusion of a navigator'
      ' (NavigationNode widget) in the tree.';

  static const String ok = 'OK';
  static const String uncaughtExceptionTitle = 'Something went wrong';
}
