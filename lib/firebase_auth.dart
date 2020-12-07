import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';

void loginUI() {
  FirebaseAuthUi.instance().launchAuth(
      [
        AuthProvider.email(),
      ],
  ).then((user) =>
    print("Logged in user is ${user.displayName}")
  ).catchError((err) => print("Error: $err"));
}

void logout() async {
  final result = await FirebaseAuthUi.instance().logout();
  print(result);
}

