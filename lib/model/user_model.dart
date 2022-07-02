class UserModel {
  int? status;
  List<Account>? account;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    account =
        List.from(json['account']).map((e) => Account.fromJson(e)).toList();
  }
}

class Account {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? updatedAt;
  String? createdAt;

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }
}
