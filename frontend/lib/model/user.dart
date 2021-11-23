class User {
  final String id;
  final String name;

  const User._(this.id, this.name);

  factory User.fromJson(Map json) {
    final id = json['_id'];
    final name = json['name'];
    return User._(id, name);
  }
}
