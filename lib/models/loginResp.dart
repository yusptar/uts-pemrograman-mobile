import 'package:uts/models/login.dart';
import 'package:uts/models/loginReq.dart';

abstract class LoginCallBack {
  void onLoginSuccess(Login login);
  void onLoginError(String error);
}

class LoginResponse {
  LoginCallBack _callBack;
  LoginRequest loginRequest = new LoginRequest();
  LoginResponse(this._callBack);

  doLogin(String username, String password) {
    loginRequest
        .getLogin(username, password)
        .then((login) => _callBack.onLoginSuccess(login))
        .catchError((onError) => _callBack.onLoginError(onError.toString()));
  }
}
