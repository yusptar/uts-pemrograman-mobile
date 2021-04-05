class Login {
  int _id;
  String _username;
  String _password;

  int get id => this._id;

  String get username => this._username;
  set username(String value) => this._username = value;

  String get password => this._password;
  set password(String value) => this._password = value;

  Login(this._username, this._password);

  Login.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._username = map['username'];
    this._password = map['password'];
  }

  Map<String, dynamic> toMapLogin() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['username'] = username;
    map['password'] = password;
    return map;
  }
}
