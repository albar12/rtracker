abstract class SignInEvent {}

class SignInClicked extends SignInEvent {
  final String username;
  final String password;

  SignInClicked({
    required this.username,
    required this.password,
  });
}
