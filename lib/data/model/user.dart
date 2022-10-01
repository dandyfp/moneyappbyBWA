class User {
  User({
    this.idUser,
    this.name,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  String? idUser;
  String? name;
  String? password;
  String? createdAt;
  String? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id_user"],
        name: json["name"],
        password: json["password"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "name": name,
        "password": password,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
