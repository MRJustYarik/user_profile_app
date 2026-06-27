/// Модель пользователя с основными данными
class User {
  final String name;
  final String email;
  final String? phone; // Необязательное поле

  User({
    required this.name,
    required this.email,
    this.phone,
  });

  /// Преобразование в Map для сохранения
  Map<String, String> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone ?? '',
    };
  }

  /// Создание объекта из Map
  factory User.fromMap(Map<String, String> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone']?.isNotEmpty == true ? map['phone'] : null,
    );
  }
}
