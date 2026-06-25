import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String avatarAsset;
  final String? avatarPath;

  const UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarAsset,
    this.avatarPath,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatarAsset,
    String? avatarPath,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarAsset: avatarAsset ?? this.avatarAsset,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }

  @override
  List<Object?> get props => [name, email, phone, avatarAsset, avatarPath];
}
