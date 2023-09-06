import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.username,
    this.email,
    this.phone,
    this.isLoggedIn,
  });

  final String id;
  final String? username;
  final String? email;
  final String? phone;
  final bool? isLoggedIn;

  static const empty = User(id: '', isLoggedIn: false);

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, username, email, phone, isLoggedIn];

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? phone,
    bool? isLoggedIn,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
