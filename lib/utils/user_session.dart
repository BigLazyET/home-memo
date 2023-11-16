class UserSeesion {
  UserSeesion._internal();

  factory UserSeesion() => _instance;

  static late final UserSeesion _instance = UserSeesion._internal();

  bool _isLogin = false;

  bool get isLogin => _isLogin;

  void setIsLogin(bool isLogin) => _isLogin = isLogin;
}
