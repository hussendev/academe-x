import 'package:academe_x/lib.dart';

class AuthTokenEntity {
  UserResponseEntity user;
  String accessToken;

  AuthTokenEntity({
    required this.user,
    required this.accessToken,
  });

  AuthTokenModel toModle() {
    return AuthTokenModel(user: user, accessToken: accessToken);
  }
}
