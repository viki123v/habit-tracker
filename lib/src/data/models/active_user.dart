import 'package:floor/floor.dart';

@entity
class ActiveUser {
  @primaryKey
  final String username;
  final String email;
  final String name;
  final String surname;
  final String? imageName;
  final int points;

  ActiveUser({
    required this.username,
    required this.email,
    required this.name,
    required this.surname,
    this.imageName,
    this.points = 0,
  });
}
