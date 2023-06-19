import 'package:meta/meta.dart';

@immutable
class UserData {
  const UserData({
    required this.name,
  });

  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserData && name == other.name;

  @override
  int get hashCode => Object.hashAll([name]);

  @override
  String toString() => 'UserData(name: $name)';
}
