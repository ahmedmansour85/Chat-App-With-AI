import 'package:user_repository/src/entites/user_enity.dart';

class MyUser {
  String id;
  String email;
  String full_name;
  String phone;
  String address;

  MyUser({
    required this.id,
    required this.email,
    required this.full_name,
    required this.phone,
    required this.address,
  });

  static MyUser empty() {
    return MyUser(
      id: '',
      email: '',
      full_name: '',
      phone: '',
      address: '',
    );
  }

  static MyUser fromEntity(UserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      full_name: entity.full_name,
      phone: entity.phone,
      address: entity.address,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      full_name: full_name,
      phone: phone,
      address: address,
    );
  }
}
