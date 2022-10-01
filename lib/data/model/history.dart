class History {
  History({
    this.idHistory,
    this.idUser,
    this.type,
    this.total,
    this.date,
    this.detail,
    this.createdAt,
    this.updatedAt,
  });

  String? idHistory;
  String? idUser;
  String? type;
  String? total;
  String? date;
  String? detail;
  String? createdAt;
  String? updatedAt;

  factory History.fromJson(Map<String, dynamic> json) => History(
        idHistory: json["id_history"],
        idUser: json["id_user"],
        type: json["type"],
        total: json["total"],
        date: json["date"],
        detail: json["detail"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_history": idHistory,
        "id_user": idUser,
        "type": type,
        "total": total,
        "date": date,
        "detail": detail,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
