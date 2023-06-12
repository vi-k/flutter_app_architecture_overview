import 'dart:async';

import 'package:flutter/material.dart';

import '../core/user_settings/user_settings_data.dart';
import '../core/user_settings/user_settings_repository.dart';
import 'user_scope.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({
    super.key,
    required this.child,
  });

  final Widget child;

  static UserSettingsData of(
    BuildContext context, {
    bool listen = true,
  }) =>
      _UserSettingsInheritedWidget.of(context, listen: listen)
          .state
          ._userSettings;

  static Future<void> update(
    BuildContext context,
    UserSettingsData newSettings,
  ) =>
      _UserSettingsInheritedWidget.of(context, listen: false)
          .state
          ._update(newSettings);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  late final UserSettingsRepository _userSettingsRepository;
  late UserSettingsData _userSettings;

  @override
  void initState() {
    super.initState();

    final userScope = UserScope.of(context);
    _userSettingsRepository = userScope.userSettingsRepository;
    _userSettings = userScope.initialUserSettings;
  }

  Future<void> _update(UserSettingsData newSettings) async {
    setState(() {
      _userSettings = newSettings;
    });
    await _userSettingsRepository.save(_userSettings);
  }

  @override
  Widget build(BuildContext context) => _UserSettingsInheritedWidget(
        state: this,
        settings: _userSettings,
        child: widget.child,
      );
}

class _UserSettingsInheritedWidget extends InheritedWidget {
  const _UserSettingsInheritedWidget({
    required this.state,
    required this.settings,
    required super.child,
  });

  final _UserSettingsState state;
  final UserSettingsData settings;

  static _UserSettingsInheritedWidget of(
    BuildContext context, {
    required bool listen,
  }) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<
              _UserSettingsInheritedWidget>()!
          : context
              .getInheritedWidgetOfExactType<_UserSettingsInheritedWidget>()!;

  @override
  bool updateShouldNotify(_UserSettingsInheritedWidget oldWidget) =>
      settings != oldWidget.settings;
}
