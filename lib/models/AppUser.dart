class AppUser {
  String? id;
  String email, userName, phone, city, country;

  AppUser({
    this.id,
    required this.email,
    required this.userName,
    required this.phone,
    required this.city,
    required this.country,
  });

// map going to firestore
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'email': email,
      'userName': userName,
      'phone': phone,
      'city': city,
      'Country': country,
    };
  }

// get map
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      // id: map['id'] ?? '',
      email: map['email'] ?? '',
      userName: map['userName'] ?? '',
      phone: map['phone'] ?? '',
      city: map['city'] ?? '',
      country: map['Country'] ?? '',
    );
  }
}
