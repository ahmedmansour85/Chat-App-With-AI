import 'package:user_repository/src/entites/user_enity.dart';

class MyUser {
  String id;
  String fullName;
  String email;
  String phone;
  String address;
  String? pic;

  MyUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.pic,
  });

  static MyUser empty() {
    return MyUser(
      id: '',
      email: '',
      fullName: '',
      phone: '',
      address: '',
      pic: '',
    );
  }

  static MyUser fromEntity(UserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      fullName: entity.fullName,
      phone: entity.phone,
      address: entity.address,
      pic: entity.pic,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      fullName: fullName,
      phone: phone,
      address: address,
      pic: pic,
    );
  }
}
