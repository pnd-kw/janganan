import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
  });

  final String id;
  final String username;
  final String email;
  final String phone;

  @override
  List<Object> get props => [id, username, email, phone];
}
