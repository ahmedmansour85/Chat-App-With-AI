import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_repository/src/models/user.dart' as models;
import 'package:user_repository/user_repository.dart';

class SupabaseUserRepo implements UserRepo {
  final SupabaseClient _supabase;

  SupabaseUserRepo({required SupabaseClient supabase}) : _supabase = supabase;

  @override
  Stream<MyUser?> get user {
    return _supabase.auth.onAuthStateChange.flatMap((authState) async* {
      if (authState.session?.user == null) {
        yield MyUser.empty();
      } else {
        final response = await _supabase
            .from('users')
            .select()
            .eq('id', authState.session!.user.id)
            .single();
        final entity = UserEntity.fromJson(response);
        yield models.MyUser.fromEntity(entity);
      }
    });
  }

  @override
  Future<void> createUser(models.MyUser user) async {
    final entity = user.toEntity();
    await _supabase.from('users').upsert(entity.toJson());
  }

  @override
  Future<void> deleteUser(String id) async {
    await _supabase.from('users').delete().eq('id', id);
  }

  @override
  Future<void> signIn(String email, String password) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signInWithApple() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.apple,
    );
  }

  @override
  Future<void> signInWithFacebook() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.facebook,
    );
  }

  @override
  Future<void> signInWithGoogle() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
    );
  }

  @override
  Future<void> signInWithTwitter() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.twitter,
    );
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<MyUser> signUp(models.MyUser user, String password) async {
    try {
      final response = await _supabase.auth.signUp(
        email: user.email,
        password: password,
      );
      user.id = response.user!.id;
      await createUser(user);
      return user;
    } catch (e) {
      if (e is AuthException) {
        if (e.message.contains('email')) {
          throw Exception('Invalid email address');
        } else if (e.message.contains('already')) {
          throw Exception('Email already registered');
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception('An unexpected error occurred');
      }
    }
  }

  @override
  Future<void> updateUser(models.MyUser user) async {
    final entity = user.toEntity();
    await _supabase.from('users').update(entity.toJson()).eq('id', user.id);
  }

  @override
  Future<bool> checkIfUserExists(String userId) async {
    final response =
        await _supabase.from('users').select('id').eq('id', userId).single();
    return response != null;
  }

  @override
  MyUser? getCurrentUser() {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      return MyUser(
        id: user.id,
        email: user.email ?? '',
        full_name: '',
        phone: '',
        address: '',
      );
    }
    return null;
  }
}
