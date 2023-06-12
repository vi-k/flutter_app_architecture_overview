import 'package:app_scope/core.dart';
import 'package:flutter/material.dart';

import 'app_scope.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AppSettings> createState() => _AppSettingsState();

  static AppSettingsData of(
    BuildContext context, {
    bool listen = true,
  }) =>
      _AppSettingsInheritedWidget.of(context, listen: listen)
          .state
          ._appSettings;

  static Future<void> update(
    BuildContext context,
    AppSettingsData newSettings,
  ) =>
      _AppSettingsInheritedWidget.of(context, listen: false)
          .state
          ._update(newSettings);
}

class _AppSettingsState extends State<AppSettings> {
  late final AppSettingsRepository _appSettingsRepository;
  late AppSettingsData _appSettings;

  @override
  void initState() {
    super.initState();

    final appScope = AppScope.of(context);
    _appSettingsRepository = appScope.appSettingsRepository;
    _appSettings = appScope.initialAppSettings;
  }

  Future<void> _update(AppSettingsData newSettings) async {
    setState(() {
      _appSettings = newSettings;
    });
    await _appSettingsRepository.save(_appSettings);
  }

  @override
  Widget build(BuildContext context) => _AppSettingsInheritedWidget(
        state: this,
        settings: _appSettings,
        child: widget.child,
      );
}

class _AppSettingsInheritedWidget extends InheritedWidget {
  const _AppSettingsInheritedWidget({
    required this.state,
    required this.settings,
    required super.child,
  });

  final _AppSettingsState state;
  final AppSettingsData settings;

  static _AppSettingsInheritedWidget of(
    BuildContext context, {
    required bool listen,
  }) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<
              _AppSettingsInheritedWidget>()!
          : context
              .getInheritedWidgetOfExactType<_AppSettingsInheritedWidget>()!;

  @override
  bool updateShouldNotify(_AppSettingsInheritedWidget oldWidget) =>
      settings != oldWidget.settings;
}
