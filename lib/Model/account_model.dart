class AccountModel {
  int? user_id;
  int? user_no;
  String? first_name;
  String? last_name;
  String? user_name;
  String? email;
  String? password;

  AccountModel(this.first_name, this.last_name, this.user_name, this.email,
      this.password);

  int? get getUserId {
    return user_id;
  }

  set setUserId(int user_id) {
    this.user_id = user_id;
  }

  int? get getUserNo {
    return user_no;
  }

  set setUserNo(int user_no) {
    this.user_no = user_no;
  }

  // Map<String, dynamic> toMap() {
  //   var map = <String, dynamic>{
  //     'first_name': first_name,
  //     'last_name': last_name,
  //     'user_name': user_name,
  //     'email': email,
  //     'password': password
  //   };
  //   return map;
  // }
  //
  // AccountModel.fromMap(Map<String, dynamic> map) {
  //   // user_id = map['user_id'];
  //   user_name = map['user_name'];
  //   first_name = map['first_name'];
  //   last_name = map['last_name'];
  //   email = map['email'];
  //   password = map['password'];
  // }
}
