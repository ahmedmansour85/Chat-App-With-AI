import 'package:user_repository/src/models/user.dart' as models;
import 'package:user_repository/user_repository.dart';

abstract class UserRepo {
  Stream<MyUser?> get user;
  Future<void> updateUser(models.MyUser user);
  Future<void> deleteUser(String id);
  Future<void> createUser(models.MyUser user);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Future<MyUser> signUp(models.MyUser user, String password);
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signInWithFacebook();
  Future<void> signInWithTwitter();
  MyUser? getCurrentUser();

  Future<bool> checkIfUserExists(String id);
}
