class UserEntity {
  final String id;
  final String email;
  final String full_name;
  final String phone;
  final String address;

  const UserEntity({
    required this.id,
    required this.email,
    required this.full_name,
    required this.phone,
    required this.address,
  });
  
    static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      email: json['email'],
      full_name: json['full_name'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': full_name,
      'phone': phone,
      'address': address,
    };
  }
}


 

