import 'package:meta/meta.dart';

@immutable
class AppSettingsData {
  const AppSettingsData({
    required this.someProperty,
  });

  final bool someProperty;

  AppSettingsData copyWith({
    bool? someProperty,
  }) =>
      AppSettingsData(
        someProperty: someProperty ?? this.someProperty,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsData && someProperty == other.someProperty;

  @override
  int get hashCode => Object.hashAll([someProperty]);
}
