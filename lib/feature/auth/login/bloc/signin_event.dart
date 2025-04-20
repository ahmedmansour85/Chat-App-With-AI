part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SigninRequred extends SigninEvent {
  final String email;
  final String password;

  const SigninRequred({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignoutRequred extends SigninEvent {
  const SignoutRequred();

  @override
  List<Object> get props => [];
}
