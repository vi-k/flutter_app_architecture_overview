import 'package:meta/meta.dart';

@immutable
class UserSettingsData {
  const UserSettingsData({
    required this.someProperty,
  });

  final bool someProperty;

  UserSettingsData copyWith({
    bool? someProperty,
  }) =>
      UserSettingsData(
        someProperty: someProperty ?? this.someProperty,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingsData && someProperty == other.someProperty;

  @override
  int get hashCode => Object.hashAll([someProperty]);
}
