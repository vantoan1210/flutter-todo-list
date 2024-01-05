import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_to_do_list/data/firestore.dart';
import 'package:flutter_to_do_list/widgets/alert_dialog.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String PasswordConfirm);
  Future<void> login(String email, String password);
}

class AuthenticationRemote extends AuthenticationDatasource {
  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  @override
  Future<void> register(
      String email, String password, String PasswordConfirm) async {
    if (PasswordConfirm == password) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        Firestore_Datasource().createUser(email);
      });
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
